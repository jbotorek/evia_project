class CreateEventCommentRelationships < ActiveRecord::Migration
  def change
    create_table :event_comment_relationships do |t|
      t.integer :commenter_id
      t.integer :event_id
      t.string :text

      t.timestamps
    end
  end
end
