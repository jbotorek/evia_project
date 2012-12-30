class AddActivityTypeToRoutes < ActiveRecord::Migration
  def change
	add_column :routes, :activity_type_id, :integer
  end
end
