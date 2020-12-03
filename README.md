# README

### Setup and Installation
* Clone the repository
* Run bundle and install dependencies
* Run `bundle exec rails db:setup` to set up your database and seed it with a few colleges, exams, and exam windows

### Running the App
* Run `bundle exec rails s` to spin up a local server

### Sending Requests
* Use Postman, or a similar tool, to send POST requests to `/exam_sessions`
* Requests should contain:
  * first_name: String
  * last_name: String
  * phone_number: String
  * college_id: Integer
  * exam_id: Integer
  * start_time: DateTime

### Testing
* Run tests with `bundle exec rails test`

### Other Notes
* No users are seeded by default. To add users, submit one or more successul requests to `/exam_sessions`
* By default, the seeded `Music 101` and `Coding 101` exams have open exam windows, while both `Final Exam` exams do not