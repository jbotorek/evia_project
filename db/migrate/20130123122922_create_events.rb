class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :route_id
      t.string :title
      t.text :description
      t.datetime :time
      t.integer :event_type_id

      t.timestamps
    end
  end
end
