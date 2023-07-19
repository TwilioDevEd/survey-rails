> ❗ This tutorial is duplicated, please see the [updated one](https://github.com/TwilioDevEd/automated-survey-rails).

<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# Automated Surveys powered by Twilio - Ruby on Rails

An example application implementing Automated Voice Surveys using Twilio.


## Installation

To run this locally on your machine:

1. Grab latest source

    ```bash
    git clone git://github.com/TwilioDevEd/survey-rails.git
    ```

2. Navigate to folder and run

    ```bash
    cd survey-rails && \
    bundle install
    ```

3. Make sure postgres is installed locally

    ```bash
    gem install pg
    ```
    * or for peeps using homebrew

    ```bash
    gem install pg -- --with-pg-config=/usr/local/bin/pg_config
    ```

4. Create the Database, run migrations and seed survey questions

    ```bash
    rake db:create db:migrate && \
    rake questions:import
    ```

5. Make sure the tests succeed

    ```bash
    rake test
    ```
6) Run the server

    ```bash
    rails server
    ```

7) Check it out at [localhost:3000/](http://localhost:3000/)

## Meta

* No warranty expressed or implied.  Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
