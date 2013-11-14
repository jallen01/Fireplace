class CreateLocationTags < ActiveRecord::Migration
  def change
    create_table :location_tags do |t|
      t.belongs_to :user, null: false

      t.string :name, null: false

      t.text :address_hash, null: false

      t.timestamps
    end
  end
end
