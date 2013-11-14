class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :user, null: false
      t.belongs_to :task

      t.string :name

      t.text :time_set
      t.text :day_set

      t.timestamps
    end
  end
end
