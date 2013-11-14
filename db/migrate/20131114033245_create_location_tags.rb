class CreateLocationTags < ActiveRecord::Migration
  def change
    create_table :location_tags do |t|

      t.timestamps
    end
  end
end
