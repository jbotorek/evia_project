class AddIndexWantTryUserId < ActiveRecord::Migration
  def change
	add_index :want_try_relationships, :wanter_id
	add_index :want_try_relationships, :wanted_route_id
  end
end
