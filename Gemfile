source 'https://rubygems.org'

# ruby '2.1.1'
ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use SCSS for stylesheets
gem 'less'
gem 'less-rails'
gem 'sass'
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.3.5'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
gem 'i18n-js'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# gem 'less-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'simplecov'
  gem 'launchy'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'factory_girl'
  gem 'factory_girl_rails', :require => false
  gem 'rspec'
  gem 'rspec-rails', '~> 3.0'
  gem 'rspec-activemodel-mocks', '~> 1.0.1'
  gem 'sqlite3'
end

group :development, :production do
  gem 'mysql2', '~> 0.3.20'
end

group :development do
  gem 'puma'
  gem 'rails-erd'
end

# For Heroku deployment
group :production do
  gem 'rails_12factor'
end

gem 'oauth'
gem 'twitter_oauth'
gem 'devise'
gem 'twitter'
gem 'twitter-bootstrap-rails'

gem 'rename'
