class UpdateItemProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :type, :string

    remove_column :items, :current_quantity, :integer
    remove_column :items, :minimum_quantity, :integer
    remove_column :items, :sale_price, :decimal

    add_column :items, :price, :decimal, precision: 15, scale: 2
    add_column :items, :late_fee, :decimal, precision: 15, scale: 2
    add_column :items, :lend_duration, :integer
    add_column :items, :lend_period_end, :datetime

    add_column :items, :active, :boolean
  end
end
