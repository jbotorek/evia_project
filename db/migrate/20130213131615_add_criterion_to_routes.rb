class AddCriterionToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :criterion, :string
  end
end
