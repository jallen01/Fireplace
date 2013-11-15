class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user

      t.string :title
      t.string :content

      t.boolean :important
      t.boolean :long_lasting
      t.date :deadline

      t.timestamps
    end
  end
end
