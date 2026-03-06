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

  def destroy # 投稿の削除
    @community = Community.find(params[:community_id]) 
    @post = @community.posts.find(params[:id])

    if @post.user == current_user
      @post.destroy
      redirect_to @community, notice: '投稿を削除しました'
    else
      redirect_to @community, alert: '投稿を削除できませんでした'
    end
  end

  def edit # 投稿の編集
    @community = Community.find(params[:community_id])
    @post = @community.posts.find(params[:id])

    redirect_to community_path(@community) unless @post.user == current_user
  end

  def update # 投稿の更新
    @community = Community.find(params[:community_id])
    @post = @community.posts.find(params[:id])

    if @post.user == current_user
      @post.update(post_params)
      redirect_to @community, notice: '投稿を更新しました'
    else
      render :edit, notice: '投稿を更新できませんでした'
    end
  end

  private

  def post_params # 投稿の作成時に必要なパラメータ
    params.require(:post).permit(:content, :image)
  end
end
