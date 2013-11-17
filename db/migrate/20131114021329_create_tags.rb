class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :user
      t.integer :parent_task_id

      t.string :name

      t.timestamps
    end
  end
end
