class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.references :user
      t.string :notes
      t.boolean :done
      t.date :date
      t.string :total
      t.timestamps
    end
  end
end
