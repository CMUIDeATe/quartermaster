class RemoveColorFromPrintRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :print_requests, :color, :string
  end
end
