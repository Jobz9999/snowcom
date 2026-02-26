class CommunitiesController < ApplicationController
    before_action :authenticate_user!

    def index # コミュニティの一覧ページ
        @communities = Community.all
    end

    def show # コミュニティの詳細ページ(現段階では使わない後々使う)
        @community = Community.find(params[:id])
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
