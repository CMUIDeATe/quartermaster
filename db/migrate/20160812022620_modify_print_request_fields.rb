class ModifyPrintRequestFields < ActiveRecord::Migration[5.0]
  def change
    change_table :print_requests do |t|
      t.rename :volume, :model_volume
      t.decimal :support_volume
      t.string :color
      t.datetime :due_at
      t.decimal :billed_price, precision: 8, scale: 2
    end
    change_column :print_requests, :quoted_price, :decimal, precision: 8, scale: 2
  end
end
