# README

### Purpose of the application

This is a very simple, web based, to-do application. This would be something that could substitute using a sticky and pen. The time limit is 5 hours (so till around 6:30PM on the Paris Timezone).

Required Stories:
- As a user, I should be able to create an account with just my email address (no password required)
- As a user, I should be able to add a todo that includes title (required), description (optional) and due date (optional)
- As a user, I should be able to reorder todos easily
- As a user, I can checkoff todos
- As a user, I can login using just my email address
- As a user, I don’t have to login unless I’ve cleared my cache

Nice to have stories (in order):
- As a user, I can add and manage todos 100% through AJAX
- As a user, I get reminded by email when a todo is past due
- As a user, I can create nested todo

### Versions

Ruby 2.7.0

Rails  6.0.3.4

Refer to Gemfile and Gemfile.lock for further information

### Install dependencies

`bundle install`

### Database creation

`rails db:create`
`rails db:migrate`

or

`rails db:migrate:reset`

### Run server in development environment

`rails s`

### How to run the test suite

`bundle exec rspec`

### Deployment instructions

`git commit`
`git push heroku master`
`heroku run rake db:migrate`

### Check code for security and style

`rubocop`

Make sure your text editor use the .editorconfig
