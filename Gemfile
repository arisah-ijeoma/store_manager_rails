source 'https://rubygems.org'

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

# Use pg as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use SCSS for stylesheets
gem 'sass'
gem 'sass-rails', '~> 5.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Template
gem 'haml'
gem 'haml-rails'

# Sensitive data
gem 'figaro'

# Form builder
gem 'formtastic', '~> 3.0'

# For user authentication
gem 'devise'
gem 'cancancan'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Start and stop postgre
gem 'launchy'

# For styling
gem 'materialize-sass'
gem 'bootstrap-material-design'
gem 'autoprefixer-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# For icons
gem 'font-awesome-sass', '~> 4.5.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Spring speeds up development by keeping your application running in the background.
# Read more: https://github.com/rails/spring
gem 'spring', group: :development

# background jobs
gem 'sidekiq'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'shoulda'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

gem 'rails_12factor', group: :production
