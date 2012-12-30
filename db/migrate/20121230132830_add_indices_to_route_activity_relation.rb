class AddIndicesToRouteActivityRelation < ActiveRecord::Migration
  def change
	add_index :route_activity_relations, :route_id
	add_index :route_activity_relations, :activity_type_id
  end
end
