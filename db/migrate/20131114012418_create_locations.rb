class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :user

      t.string :name

      t.float :latitude
      t.float :longitude
      t.text :address_string

      t.timestamps
    end
  end
end
