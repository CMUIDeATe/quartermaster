class DropOldTagsAndTypes < ActiveRecord::Migration[5.0]

  def up
    drop_table :tags
    drop_table :types
    drop_join_table :items, :tags
    drop_join_table :items, :types
  end

  def down
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
    create_table :types do |t|
      t.string :name
      t.timestamps
    end
    create_join_table :items, :tags do |t|
      t.references :item, foreign_key: true
      t.references :tag, foreign_key: true
    end
    create_join_table :items, :types do |t|
      t.references :item, foreign_key: true
      t.references :type, foreign_key: true
    end
  end

end
