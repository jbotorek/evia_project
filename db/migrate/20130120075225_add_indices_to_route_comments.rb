class AddIndicesToRouteComment < ActiveRecord::Migration
  def change
    add_index :route_comment_relationships, :route_id
	add_index :route_comment_relationships, :commenter_id
  end
end
