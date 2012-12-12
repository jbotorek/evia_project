class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.text :map

      t.timestamps
    end
	add_index :routes, [:title, :created_at, :user_id]
  end
end
