class AddShelfLocationToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :shelf_location, :string
  end
end
