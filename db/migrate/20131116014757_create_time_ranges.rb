class CreateTimeRanges < ActiveRecord::Migration
  def change
    create_table :time_ranges do |t|
      t.belongs_to :user
      t.integer :parent_tag_id

      t.string :name
      t.text :time_set

      t.timestamps
    end
  end
end
