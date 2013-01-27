class AddIndicesRouteComment < ActiveRecord::Migration
  def change
	add_index :event_comment_relationships, :commenter_id
	add_index :event_comment_relationships, :event_id
  end
end
