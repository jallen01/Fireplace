class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.integer :parent_tag_id, null: false
      t.integer :child_tag_id, null: false

      t.timestamps
    end
  end
end
