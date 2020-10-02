# Prerequisites

* Github

* Ruby 2.5.7

* Rails 6.0.3

* Check out the repository

# Installation

Follow these easy steps to install and start the app:

* bundle install

* rake db:create

* rake db:setup

* rails db:migrate

Now, Create testing user in rails console, Open console

* rails c

Create user by adding this command

* User.create(name: "Testing user", role: "admin, email: "testing.user@gmail.com", password: "Password", password_confirmation: "Password")

# Start the app

* rails s
