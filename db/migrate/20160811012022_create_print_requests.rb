class CreatePrintRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :print_requests do |t|
      t.references :user, foreign_key: true
      t.integer :quantity
      t.decimal :volume
      t.decimal :quoted_price
      t.text :notes

      t.timestamps
    end
  end
end
