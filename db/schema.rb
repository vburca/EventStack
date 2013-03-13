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

ActiveRecord::Schema.define(:version => 20130313194831) do

  create_table "events", :force => true do |t|
    t.string   "name",           :limit => 100, :null => false
    t.text     "description",    :limit => 800, :null => false
    t.datetime "start_datetime",                :null => false
    t.datetime "end_datetime",                  :null => false
    t.string   "location",                      :null => false
    t.boolean  "food_provided"
    t.integer  "creator_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "events", ["creator_id"], :name => "index_events_on_creator_id"

  create_table "events_majors", :id => false, :force => true do |t|
    t.integer "event_id", :null => false
    t.integer "major_id", :null => false
  end

  add_index "events_majors", ["event_id", "major_id"], :name => "index_events_majors_on_event_id_and_major_id"
  add_index "events_majors", ["major_id"], :name => "index_events_majors_on_major_id"

  create_table "majors", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "majors_users", :id => false, :force => true do |t|
    t.integer "major_id", :null => false
    t.integer "user_id",  :null => false
  end

  add_index "majors_users", ["major_id", "user_id"], :name => "index_majors_users_on_major_id_and_user_id"
  add_index "majors_users", ["user_id"], :name => "index_majors_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "nickname",      :limit => 20
    t.string   "first_name",                  :null => false
    t.string   "last_name",                   :null => false
    t.date     "date_of_birth"
    t.string   "sex"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "votes", :id => false, :force => true do |t|
    t.integer "voter_id",       :null => false
    t.integer "voted_event_id", :null => false
  end

  add_index "votes", ["voted_event_id"], :name => "index_votes_on_voted_event_id"
  add_index "votes", ["voter_id", "voted_event_id"], :name => "index_votes_on_voter_id_and_voted_event_id"

end
