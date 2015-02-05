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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150203211243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "survey_answers", force: true do |t|
    t.text     "answer"
    t.integer  "survey_question_id"
    t.integer  "survey_response_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "survey_answers", ["survey_response_id"], name: "index_survey_answers_on_survey_response_id", using: :btree

  create_table "survey_participants", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "survey_questions", force: true do |t|
    t.text     "body"
    t.boolean  "input_required"
    t.boolean  "recording"
    t.integer  "survey_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "survey_questions", ["survey_id"], name: "index_survey_questions_on_survey_id", using: :btree

  create_table "survey_responses", force: true do |t|
    t.integer  "survey_participant_id"
    t.integer  "survey_id"
    t.integer  "survey_answers_id"
    t.integer  "current_question"
    t.datetime "response_date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "survey_responses", ["survey_id"], name: "index_survey_responses_on_survey_id", using: :btree
  add_index "survey_responses", ["survey_participant_id"], name: "index_survey_responses_on_survey_participant_id", using: :btree

  create_table "surveys", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
