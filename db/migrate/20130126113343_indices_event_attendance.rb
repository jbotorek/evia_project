class IndicesEventAttendance < ActiveRecord::Migration
    def change
	  add_index :event_attends, :attendee_id
	  add_index :event_attends, :attend_event_id
	  add_index :event_attends, [:attendee_id, :attend_event_id], unique: true
    end
end
