class AddIndexToInfos < ActiveRecord::Migration
  def change
    add_index :infos, :surname
	add_index :infos, :town
	add_index :infos, :user_id, unique: true
  end
end
