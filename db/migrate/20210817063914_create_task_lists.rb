class CreateTaskLists < ActiveRecord::Migration[6.1]
  def change
    create_table :task_lists do |t|
      t.references :task, null: false, foreign_key: true
      t.string :to_do
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
