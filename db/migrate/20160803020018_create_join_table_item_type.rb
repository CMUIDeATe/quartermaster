class CreateJoinTableItemType < ActiveRecord::Migration[5.0]
  def change
    create_join_table :items, :types do |t|
      t.references :item, foreign_key: true
      t.references :type, foreign_key: true
    end
  end
end
