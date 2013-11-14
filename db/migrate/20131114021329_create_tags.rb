class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :time_data
      t.

      t.timestamps
    end
  end
end
