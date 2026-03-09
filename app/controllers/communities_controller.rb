class CommunitiesController < ApplicationController
    before_action :authenticate_user!

    def index # コミュニティの一覧ページ
        if params[:keyword].present?
            @communities = Community.where("name LIKE?", "%#{params[:keyword]}%")
        else
            @communities = Community.all
        end
    end

    def show # コミュニティの詳細ページ
        @community = Community.find(params[:id]) 
        @posts = @community.posts.includes(:user).order(created_at: :desc).page(params[:page]) #ページネーション
        @post = Post.new # 投稿の新規作成フォームを表示するために必要
    end
    
    def new # コミュニティの新規作成ページ
        @community = Community.new
    end

    def create # コミュニティの作成
        @community = Community.new(community_params)
        @community.user = current_user
        if @community.save
            redirect_to @community, notice: 'コミュニティを作成しました'
        else
            render :new
        end
    end

    private

    def community_params # コミュニティの作成時に必要なパラメータ
        params.require(:community).permit(:name, :description)
    end
end
