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

ActiveRecord::Schema.define(:version => 20130127071627) do

  create_table "activity_types", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "event_attends", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "attend_event_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "event_attends", ["attend_event_id"], :name => "index_event_attends_on_attend_event_id"
  add_index "event_attends", ["attendee_id", "attend_event_id"], :name => "index_event_attends_on_attendee_id_and_attend_event_id", :unique => true
  add_index "event_attends", ["attendee_id"], :name => "index_event_attends_on_attendee_id"

  create_table "event_comment_relationships", :force => true do |t|
    t.integer  "commenter_id"
    t.integer  "event_id"
    t.string   "text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "event_comment_relationships", ["commenter_id"], :name => "index_event_comment_relationships_on_commenter_id"
  add_index "event_comment_relationships", ["event_id"], :name => "index_event_comment_relationships_on_event_id"

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "route_id"
    t.string   "title"
    t.text     "description"
    t.datetime "time"
    t.integer  "event_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "events", ["route_id"], :name => "index_events_on_route_id"
  add_index "events", ["time"], :name => "index_events_on_time"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "infos", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "surname"
    t.string   "gender"
    t.string   "street"
    t.string   "house_number"
    t.string   "town"
    t.text     "bio"
    t.text     "image"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "infos", ["surname"], :name => "index_infos_on_surname"
  add_index "infos", ["town"], :name => "index_infos_on_town"
  add_index "infos", ["user_id"], :name => "index_infos_on_user_id", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "route_activity_relations", :force => true do |t|
    t.integer  "route_id"
    t.integer  "activity_type_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "route_activity_relations", ["activity_type_id"], :name => "index_route_activity_relations_on_activity_type_id"
  add_index "route_activity_relations", ["route_id"], :name => "index_route_activity_relations_on_route_id"

  create_table "route_comment_relationships", :force => true do |t|
    t.integer  "commenter_id"
    t.integer  "route_id"
    t.string   "text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "route_comment_relationships", ["commenter_id"], :name => "index_route_comment_relationships_on_commenter_id"
  add_index "route_comment_relationships", ["route_id"], :name => "index_route_comment_relationships_on_route_id"

  create_table "routes", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.text     "map"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "activity_type_id"
  end

  add_index "routes", ["title", "created_at", "user_id"], :name => "index_routes_on_title_and_created_at_and_user_id"

  create_table "tried_relationships", :force => true do |t|
    t.integer  "trier_id"
    t.integer  "tried_route_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "tried_relationships", ["tried_route_id"], :name => "index_tried_relationships_on_tried_route_id"
  add_index "tried_relationships", ["trier_id"], :name => "index_tried_relationships_on_trier_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "want_try_relationships", :force => true do |t|
    t.integer  "wanter_id"
    t.integer  "wanted_route_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "want_try_relationships", ["wanted_route_id"], :name => "index_want_try_relationships_on_wanted_route_id"
  add_index "want_try_relationships", ["wanter_id"], :name => "index_want_try_relationships_on_wanter_id"

end
