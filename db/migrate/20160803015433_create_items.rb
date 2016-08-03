class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :barcode
      t.string :name
      t.text :description
      t.integer :current_quantity
      t.integer :minimum_quantity
      t.decimal :sale_price
      t.text :notes

      t.timestamps
    end
  end
end
