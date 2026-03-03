class PostsController < ApplicationController
  def create # 投稿の作成
    @community = Community.find(params[:community_id]) # 投稿を作成するコミュニティを取得(コミュニティの詳細ページにリダイレクトするために必要)
    @post = @community.posts.new(post_params)          # 投稿をコミュニティに関連づけて作成
    @post.user = current_user                          # 投稿の作成者を現在のユーザーに設定
    if @post.save
      redirect_to @community, notice: '投稿を作成しました'
    else
      render 'communities/show' 
    end
  end
  private

  def post_params # 投稿の作成時に必要なパラメータ
    params.require(:post).permit(:content)
  end
end
