require 'twilio-ruby'
require 'sanitize'


class SurveysController < ApplicationController
  before_action :set_caller_survey, only: [:get_answer, :connect_call]
  protect_from_forgery :except => [:get_answer]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end
  
  # GET /api/get_answer
  def get_answer

    # Check if the answer is a recording or a keypad entry
    if params[:RecordingUrl].nil?

      # Handle a keypad answer
      # The digits the user inputted
      input = params[:Digits]
    else

      # Handle a recording
      input = params[:RecordingUrl]
    end

    # Grab the caller's response thus far
    @caller_response = @caller.survey_responses.find_by(survey_id: @survey[:id])
    @current_answer = @caller_response.survey_answers.where(answer: nil).first
    @current_answer.update(answer: input)

    # redirect '/call' unless input
    redirect_to(:action => :connect_call) and return
  end

  # GET api/connect_call
  def connect_call

    # Create a new SurveyResponse if it doesn't already exist
    @survey_response = SurveyResponse.where(survey_id: @survey[:id], survey_participant_id: @caller[:id]).first_or_create()

    # Add the new SurveyResponse to the owners
    @caller.survey_responses << @survey_response
    @survey.survey_responses << @survey_response
    
    # Assign some handy variables to reference the current survey_response
    @caller_survey = @caller.surveys.last
    @caller_response = @caller.survey_responses.where(survey_id: @survey[:id]).last
    
    # Check if the caller has responded to any questions
    if not @caller_response.survey_answers.exists?

      # Create a new collection of survey_answers on the caller_response
      @caller_survey.survey_questions.each do |question|
        @survey_answer = SurveyAnswer.where(survey_response_id: @survey_response[:id], survey_question_id: question[:id]).first_or_create()
        @caller_response.survey_answers << @survey_answer
      end

    end

    @unanswered_questions = @caller_response.survey_answers.where(answer: nil)
    
    # Check if the caller has any unanswered questions in this survey
    if @unanswered_questions.length > 0
      # Get the id for the question associated with the first unanswered survey_answer
      @next_question_id = @unanswered_questions.first[:survey_question_id]
      @next_question = @survey.survey_questions.find_by(id: @next_question_id)

      # Respond with some TwiML to kick-off the survey
      response = Twilio::TwiML::Response.new do |r|

        # If it's an input question use Gather
        if @next_question[:recording] == false
          r.Gather :numDigits => '1', :action => '/api/get_answer', :method => 'get' do |g|
            g.Say @next_question[:body], voice: 'alice', language: 'en-GB'
            g.Say '0 is the lowest. 9 is the highest.', voice: 'man', language: 'en-US'
          end

        # If it's a free-form question record the user
        else
          r.Say @next_question[:body], voice: 'alice', language: 'en-GB'
          r.Say "Please record your response after the beep.", voice: 'alice', language: 'en-GB'
          r.Record :timeout => '5', :method => 'get', :action => '/api/get_answer', :finishOnKey => '#', :maxLength => '90'
        end

      end

    # Looks like the caller is done with the survey
    else
      # For testing
      puts "Caller has no survey available"

      # Respond with some TwiML to kick-off the survey
      response = Twilio::TwiML::Response.new do |r|
        r.Say "Thank you for taking the survey. In appreciation we will be sending you something special. Yours truly, The Dev-Ed team.", voice: 'alice', language: 'en-GB'
      end

    end

    render text: response.text
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_caller_survey
    # Get phone_number from the incoming GET request from Twilio
    @phone_number = Sanitize.clean(params[:From])

    # Get a survey
    @survey = Survey.last

    # Create new Survey Participant with phone_number
    @caller = SurveyParticipant.where(phone_number: @phone_number).first_or_create()
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def survey_params
    params[:survey]
  end
end