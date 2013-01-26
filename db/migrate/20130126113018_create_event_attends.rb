class CreateEventAttends < ActiveRecord::Migration
  def change
    create_table :event_attends do |t|
      t.integer :attendee_id
      t.integer :attend_event_id

      t.timestamps
    end
  end
end
