class CreateTagLocations < ActiveRecord::Migration
  def change
    create_table :tag_locations do |t|
      t.belongs_to :location
      t.belongs_to :tag

      t.timestamps
    end
  end
end
