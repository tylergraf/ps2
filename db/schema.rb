# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111009035223) do

  create_table "check_ins", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "done"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "check_ins_tasks", :id => false, :force => true do |t|
    t.integer "task_id",     :null => false
    t.integer "check_in_id", :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.string   "task"
    t.string   "task_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.string   "auth_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
