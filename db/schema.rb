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

ActiveRecord::Schema.define(:version => 20110521012556) do

  create_table "news", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "text"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.date     "date_of_establishment"
    t.string   "email"
    t.text     "informations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.date     "birthday"
    t.string   "phone"
    t.string   "genre"
    t.string   "profession"
    t.text     "interests"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.string   "type"
    t.string   "password"
    t.string   "password_salt"
  end

end
