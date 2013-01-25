class AddIndiceToEvent < ActiveRecord::Migration
  def change
    add_index :events, :user_id
	add_index :events, :route_id
	add_index :events, :time
  end
end