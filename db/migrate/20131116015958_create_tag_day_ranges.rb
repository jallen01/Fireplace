class CreateTagDayRanges < ActiveRecord::Migration
  def change
    create_table :tag_day_ranges do |t|
      t.belongs_to :day_range
      t.belongs_to :tag

      t.timestamps
    end
  end
end
