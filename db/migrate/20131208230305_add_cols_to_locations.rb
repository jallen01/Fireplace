class AddColsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :street, :string
    add_column :locations, :city, :string
    add_column :locations, :state, :string
    add_column :locations, :zip_code, :string
    remove_column :locations, :address_string, :string
  end
end
