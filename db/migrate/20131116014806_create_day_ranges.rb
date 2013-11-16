class CreateDayRanges < ActiveRecord::Migration
  def change
    create_table :day_ranges do |t|
      t.belongs_to :user
      t.integer :parent_tag_id

      t.string :name
      t.text :day_set

      t.timestamps
    end
  end
end
