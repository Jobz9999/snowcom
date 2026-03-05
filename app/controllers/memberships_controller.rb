class MembershipsController < ApplicationController
  before_action :set_community

  def create
    @community.memberships.create(user: current_user)
    redirect_to @community,notice: 'コミュニティに参加しました'
  end

  def destroy
    membership = @community.memberships.find_by(user: current_user)
    membership&.destroy
    redirect_to @community,notice: 'コミュニティから退出しました'
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end
end
