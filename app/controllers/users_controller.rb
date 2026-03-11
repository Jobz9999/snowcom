class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @communities = @user.joined_communities #参加しているコミュニティ
    @my_communities = @user.communities  #作成したコミュニティ
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile)
  end

end
