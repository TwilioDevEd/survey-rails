class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|

      t.timestamps
    end

    create_table :survey_questions do |t|
      t.text :body
      t.boolean :recording
      t.belongs_to :survey, index: true
      t.timestamps null: false
    end

    create_table :survey_participants do |t|
      t.string :name
      t.string :phone_number
      t.timestamps null: false
    end

    create_table :survey_responses do |t|
      t.references :survey_participant, index: true
      t.references :survey, index: true
      t.references :survey_answers
      t.integer :current_question
      t.datetime :response_date
      t.timestamps null: false
    end

    create_table :survey_answers do |t|
      t.text :answer
      t.references :survey_question
      t.references :survey_response, index: true
      t.timestamps null: false
    end

  end
end
