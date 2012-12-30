class AddIndicesToTriedRelationships < ActiveRecord::Migration
  def change
	add_index :tried_relationships, :trier_id
	add_index :tried_relationships, :tried_route_id
  end
end
