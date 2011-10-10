class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user
      t.date :date
      t.string :notes
      t.timestamps
    end
  end
end
