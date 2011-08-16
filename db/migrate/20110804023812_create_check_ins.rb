class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :user_id
      t.boolean :morning_prayer
      t.boolean :evening_prayer
      t.boolean :scripture_study
      t.boolean :service
      t.string :notes
      t.boolean :read
      t.date :date
      t.string :total

      t.timestamps
    end
  end
end
