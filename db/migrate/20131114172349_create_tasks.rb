class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user

      t.string :title
      t.string :content

      t.boolean :important
      t.boolean :quick
      t.date :deadline
      t.integer :days_notice

      t.timestamps
    end
  end
end
