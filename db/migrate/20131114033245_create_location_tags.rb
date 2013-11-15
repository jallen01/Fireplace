class CreateLocationTags < ActiveRecord::Migration
  def change
    create_table :location_tags do |t|
      t.belongs_to :user

      t.string :name

      t.text :address_hash

      t.timestamps
    end
  end
end
