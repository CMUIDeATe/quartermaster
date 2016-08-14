class CreatePrintRequestStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :print_request_statuses do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
