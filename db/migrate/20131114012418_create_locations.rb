class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :user

      t.float :latitude
      t.float :longitude

      t.text :address_data

      t.timestamps
    end
  end
end
