class CommunitiesController < ApplicationController
    before_action :authenticate_user!

    def index # コミュニティの一覧ページ
        @communities = Community.all
      
        if params[:keyword].present?
          @communities = @communities.where("name LIKE ?", "%#{params[:keyword]}%")
        end
      
        if params[:category_id].present?
          @communities = @communities.where(category_id: params[:category_id])
        end
    end

    def show # コミュニティの詳細ページ
        @community = Community.find(params[:id]) 
        @posts = @community.posts.includes(:user).order(created_at: :desc).page(params[:page]) #ページネーション
        @post = Post.new # 投稿の新規作成フォームを表示するために必要

        if @community.user == current_user && @community.approval_required?
          @pending_memberships = @community.memberships.pending.includes(:user).order(created_at: :asc)
        end
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

    def edit
        @community = Community.find(params[:id])
      end
      
    def update
      @community = Community.find(params[:id])
    
      if @community.update(community_params)
        redirect_to @community, notice: "コミュニティ情報を更新しました"
      else
        render :edit
      end
    end

    def destroy
      @community = Community.find(params[:id])
      @community.destroy
      redirect_to communities_path, notice: "コミュニティを削除しました"
    end

    private

    def community_params # コミュニティの作成時に必要なパラメータ
        params.require(:community).permit(:name, :description, :category_id, :approval_required)
    end
end
