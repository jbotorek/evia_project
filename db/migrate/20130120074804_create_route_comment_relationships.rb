class CreateRouteCommentRelationships < ActiveRecord::Migration
  def change
    create_table :route_comment_relationships do |t|
      t.integer :commenter_id
      t.integer :route_id
      t.string :text

      t.timestamps
    end
  end
end
