class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user
      t.string :task
      t.string :task_frequency
      t.timestamps
    end
  end
end
