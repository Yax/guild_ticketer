# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091014201149) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticket_type"
  end

  create_table "messages", :force => true do |t|
    t.integer  "ticket_id"
    t.text     "content"
    t.string   "from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "from_client"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "category_id"
    t.string   "employee_name"
    t.integer  "order_number"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "basic_state"
    t.string   "type"
    t.string   "state"
    t.string   "subject"
    t.text     "explanation"
    t.integer  "basic_state_order"
  end

end
