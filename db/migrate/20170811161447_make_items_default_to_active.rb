class MakeItemsDefaultToActive < ActiveRecord::Migration[5.0]
  def change
    change_column_default :items, :active, from: nil, to: true
  end
end
