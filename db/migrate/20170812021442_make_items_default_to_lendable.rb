class MakeItemsDefaultToLendable < ActiveRecord::Migration[5.0]
  def change
    change_column_default :items, :type, from: nil, to: 'LendableItem'
  end
end
