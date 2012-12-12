class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :user_id
      t.string :name
      t.string :surname
      t.string :gender
      t.string :street
      t.string :house_number
      t.string :town
      t.text :bio
      t.text :image

      t.timestamps
    end
  end
end
