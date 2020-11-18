# README

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

Things you may want to cover:

* Ruby version

ruby 2.7.0p0
Rails 6.0.3.4

* System dependencies

* Configuration

* Database creation
`rails db:migrate:reset`

* How to run the test suite

`bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
`git commit; git push heroku master`

* ...

TODO

Models

User  id:uuid email:string
Task  id:uuid user_id:uuid title:string description:text due_date:datetime done:boolean order:int



