class AddHourToEvent < ActiveRecord::Migration
  def change
    add_column :events, :hour, :time
  end
end
