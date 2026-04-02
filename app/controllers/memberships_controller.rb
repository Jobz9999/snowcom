class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :require_community_owner!, only: [:approve, :reject, :expel]

  def create
    membership = @community.memberships.find_or_initialize_by(user: current_user)

    if @community.approval_required?
      membership.status = :pending
      notice_message = '参加リクエストを送信しました'
    else
      membership.status = :approved
      notice_message = 'コミュニティに参加しました'
    end

    if membership.save
      redirect_to @community, notice: notice_message
    else
      redirect_to @community, alert: '参加に失敗しました'
    end
  end

  def destroy
    membership = @community.memberships.find_by(user: current_user)
    membership&.destroy
    redirect_to @community,notice: 'コミュニティから退出しました'
  end

  def approve
    membership = @community.memberships.find(params[:id])
    membership.update!(status: :approved)
    redirect_to @community, notice: '参加リクエストを承認しました'
  end

  def reject
    membership = @community.memberships.find(params[:id])
    membership.destroy!
    redirect_to @community, notice: '参加リクエストを拒否しました'
  end

  def expel
    membership = @community.memberships.find(params[:id])

    if membership.user_id == @community.user_id
      redirect_to @community, alert: '作成者を追放することはできません'
      return
    end

    unless membership.approved?
      redirect_to @community, alert: '承認済みメンバーのみ追放できます'
      return
    end

    expelled_name = membership.user.name
    membership.destroy!
    redirect_to @community, notice: "#{expelled_name}を追放しました"
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def require_community_owner!
    redirect_to @community, alert: '権限がありません' unless @community.user == current_user
  end
end
