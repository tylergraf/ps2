class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.references :user
      t.boolean :done
      t.date :date
      t.timestamps
    end
  end
end
