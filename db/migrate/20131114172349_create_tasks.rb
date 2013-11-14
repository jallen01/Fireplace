class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, null: false

      t.string :title, null: false
      t.string :content

      t.boolean :important
      t.boolean :long_lasting

      t.timestamps
    end
  end
end
