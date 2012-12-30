class CreateRouteActivityRelations < ActiveRecord::Migration
  def change
    create_table :route_activity_relations do |t|
      t.integer :route_id
      t.integer :activity_type_id

      t.timestamps
    end
  end
end
