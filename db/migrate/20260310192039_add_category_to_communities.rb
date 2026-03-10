class AddCategoryToCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :communities, :category, :integer
  end
end
