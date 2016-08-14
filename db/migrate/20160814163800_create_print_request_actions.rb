class CreatePrintRequestActions < ActiveRecord::Migration[5.0]
  def change
    create_table :print_request_actions do |t|
      t.references :print_request, foreign_key: true
      t.references :print_request_status, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
