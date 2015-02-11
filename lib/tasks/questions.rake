# In a production app this would most likely be an external resource like google docs or pulled from your own CMS
SURVEY_QARRAY = [
  {
    :body => "Hello. Thanks for taking the Twillio Developer Education survey. On a scale of 0 to 9 how would you rate this tutorial? ",
    :recording => false
  },
  {
    :body => "On a scale of 0 to 9 how would you rate the design of this tutorial?",
    :recording => false
  },
  {
    :body => "In your own words please describe your feelings about Twillio right now? Press the pound sign when you are finished.",
    :recording => true
  },
  {
    :body => "On a scale of 8 to 9 how much do like my voice? Please be honest, I dislike liars.",
    :recording => false
  }
]

namespace :questions do
  desc "Import questions to db from static array"
  task import: :environment do
    @survey = Survey.new
    @survey.save
    SURVEY_QARRAY.each do |q|
      @sq = @survey.survey_questions.create(body: q[:body], recording: q[:recording])
    end
    @survey.save
    puts 'Survey questions imported.'
  end

end
