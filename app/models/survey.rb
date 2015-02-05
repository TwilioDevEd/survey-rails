class Survey < ActiveRecord::Base
  has_many :survey_questions, dependent: :destroy
  has_many :survey_responses
  has_many :survey_participants, through: :survey_responses
end
 
class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  has_one :survey_answer
end

class SurveyParticipant < ActiveRecord::Base
  has_many :survey_responses
  has_many :surveys, through: :survey_responses
end

class SurveyResponse < ActiveRecord::Base
  belongs_to :survey_participant
  belongs_to :survey
  has_many :survey_answers
  has_many :survey_questions, through: :survey_answers
end

class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey_question
  belongs_to :survey_response
end