Rails.application.routes.draw do
  resources :surveys

  # Root of the app
  root 'surveys#import'
  
  # import surveys
  get 'import' => 'surveys#import'

  # webhook for Twilio survey number
  match 'api/connect_call' => 'surveys#connect_call', via: [:get, :post]

  # callback for user entry
  match 'api/get_answer' => 'surveys#get_answer', via: [:get, :post]

end
