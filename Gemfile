source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

group :production do

  # Use PostgreSQL as the database for Active Record in production
  gem 'pg'

  # This gem enables delpoyment to Heroku.
  gem 'rails_12factor', '~> 0.0.2'
end

group :development do
  
  # Use rails_layout to generate Devise layouts files and flash messages.
  gem 'rails_layout'

  # Use sqlite3 as the database for Active Record in development.
  gem 'sqlite3'

end

group :test do

  # Use Database Cleaner to ensure a clean state for testing.
  gem 'database_cleaner'

  gem 'capybara', "~> 2.2.1"
end

group :development, :test do
  # Use RSpec for testing.
  gem 'rspec-rails'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use BootStrap for CSS framework
gem 'bootstrap-sass'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use AppSignal for errr monitoring.
# gem 'appsignal'

# Use Devise for authentication
gem 'devise'

# Use Devise-twitter to connect Devise to Twitter.
# gem 'devise-twitter'

# Use Faker to help generate development data automatically
gem 'faker'

# Use Figaro for handling credentials.
gem 'figaro'

# Use Letter Opener for previewing email in the browser instead of sending it.
gem "letter_opener", :group => :development

gem 'omniauth-twitter'

# Use Sidekiq to run background processes.
gem 'sidekiq'

# Use twitter to interface with Twitter API using Ruby.
# gem 'twitter'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
