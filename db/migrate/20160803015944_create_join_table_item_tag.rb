class CreateJoinTableItemTag < ActiveRecord::Migration[5.0]
  def change
    create_join_table :items, :tags do |t|
      t.references :item, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
