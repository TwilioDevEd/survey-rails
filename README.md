# Automated Surveys powered by Twilio - Ruby on Rails

An example application implementing Automated Voice Surveys using Twilio.  For a
step-by-step tutorial, [visit this
link](https://www.twilio.com/docs/howto/walkthrough/automated-survey/ruby/rails).

Deploy this example app to Heroku now!

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/TwilioDevEd/survey-rails)

## Installation

To run this locally on your machine:

1) Grab latest source
<pre>
git clone git://github.com/TwilioDevEd/survey-rails.git 
</pre>

2) Navigate to folder and run
<pre>
bundle install
</pre>

3) Make sure postgres is installed locally
<pre>
gem install pg 
</pre>
* or for peeps using homebrew
<pre>
gem install pg -- --with-pg-config=/usr/local/bin/pg_config
</pre>

4) Create the Database and run migrations
<pre>
rake db:create db:migrate
</pre>

5) Make sure the tests succeed
<pre>
rake test
</pre>

6) Run the server
<pre>
rails server
</pre>

7) Check it out at [localhost:3000/](http://localhost:3000/)

## Meta 

* No warranty expressed or implied.  Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
