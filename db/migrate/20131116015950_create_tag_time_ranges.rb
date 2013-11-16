class CreateTagTimeRanges < ActiveRecord::Migration
  def change
    create_table :tag_time_ranges do |t|
      t.belongs_to :time_range
      t.belongs_to :tag

      t.timestamps
    end
  end
end
