class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :require_approved_member_for_posting!, only: [:create]

  def create # 投稿の作成
    @post = @community.posts.new(post_params)          # 投稿をコミュニティに関連づけて作成
    @post.user = current_user                          # 投稿の作成者を現在のユーザーに設定
    if @post.save
      redirect_to @community, notice: '投稿を作成しました'
    else
      render 'communities/show' 
    end
  end

  def destroy # 投稿の削除
    @post = @community.posts.find(params[:id])

    if @post.user == current_user || @community.user == current_user
      @post.destroy
      redirect_to @community, notice: '投稿を削除しました'
    else
      redirect_to @community, alert: '投稿を削除できませんでした'
    end
  end

  def edit # 投稿の編集
    @post = @community.posts.find(params[:id])

    redirect_to community_path(@community) unless @post.user == current_user
  end

  def update # 投稿の更新
    @post = @community.posts.find(params[:id])

    if @post.user == current_user
      @post.update(post_params)
      redirect_to @community, notice: '投稿を更新しました'
    else
      render :edit, notice: '投稿を更新できませんでした'
    end
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def require_approved_member_for_posting!
    return if @community.user == current_user

    membership = @community.memberships.find_by(user: current_user)
    return if membership&.approved?

    redirect_to @community, alert: '参加していないコミュニティには投稿できません'
  end

  def post_params # 投稿の作成時に必要なパラメータ
    params.require(:post).permit(:content, :image)
  end
end
