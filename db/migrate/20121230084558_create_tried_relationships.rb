class CreateTriedRelationships < ActiveRecord::Migration
  def change
    create_table :tried_relationships do |t|
      t.integer :trier_id
      t.integer :tried_route_id

      t.timestamps
    end
  end
end
