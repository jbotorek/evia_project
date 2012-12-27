class CreateWantTryRelationships < ActiveRecord::Migration
  def change
    create_table :want_try_relationships do |t|
      t.integer :wanter_id
      t.integer :wanted_route_id

      t.timestamps
    end
  end
end
