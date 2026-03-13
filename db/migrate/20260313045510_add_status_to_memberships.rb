class AddStatusToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :status, :integer
  end
end
