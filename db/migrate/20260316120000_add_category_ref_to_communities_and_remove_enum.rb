class AddCategoryRefToCommunitiesAndRemoveEnum < ActiveRecord::Migration[7.1]
  def change
    add_reference :communities, :category, foreign_key: true
    remove_column :communities, :category, :integer
  end
end

