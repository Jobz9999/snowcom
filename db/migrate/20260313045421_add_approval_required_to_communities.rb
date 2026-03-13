class AddApprovalRequiredToCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :communities, :approval_required, :boolean
  end
end
