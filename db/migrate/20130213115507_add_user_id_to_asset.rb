class AddUserIdToAsset < ActiveRecord::Migration
  def change
	add_column :assets, :user_id, :integer
	add_index :assets, :user_id
	add_index :assets, :route_id
  end
end
