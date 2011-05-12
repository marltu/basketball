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

ActiveRecord::Schema.define(:version => 0) do

  create_table "fouls", :force => true do |t|
    t.integer "match_member_id", :null => false
    t.integer "against_id"
  end

  create_table "match_members", :force => true do |t|
    t.integer "match_id",       :null => false
    t.integer "team_member_id", :null => false
    t.string  "team_type",      :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer "team_home_id", :null => false
    t.integer "team_away_id", :null => false
  end

  create_table "people", :force => true do |t|
    t.string "name"
    t.string "surname"
  end

  create_table "team_members", :force => true do |t|
    t.integer "person_id", :null => false
    t.integer "team_id",   :null => false
    t.integer "number",    :null => false
  end

  create_table "teams", :force => true do |t|
    t.string "name"
  end

  create_table "throws", :force => true do |t|
    t.integer "match_member_id", :null => false
    t.integer "points",          :null => false
    t.boolean "accurate",        :null => false
  end

end
