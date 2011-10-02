class CreateJoinTasksCheckins < ActiveRecord::Migration
  def up
    create_table :check_ins_tasks, :id => false do |t|
      t.references :task, :null => false
      t.references :check_in, :null => false
    end
  end
end
