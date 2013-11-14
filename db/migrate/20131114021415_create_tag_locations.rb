class CreateTagLocations < ActiveRecord::Migration
  def change
    create_table :tag_locations do |t|

      t.timestamps
    end
  end
end
