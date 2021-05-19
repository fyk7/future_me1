source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '5.2.3'

gem 'mysql2'
gem 'dotenv-rails'
gem 'rubocop'
gem 'rails-i18n', '~> 5.1'

gem 'activeadmin'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'

gem 'omniauth'
gem 'omniauth-twitter'

gem 'bootstrap'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'faker'

gem 'carrierwave'
gem 'mini_magick'

gem 'rinku'
gem 'ransack'
gem 'kaminari'  
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'


# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
  
  gem 'factory_bot_rails'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'

  gem 'launchy'
  #gem 'chromedriver-helper'
  gem 'webdrivers'
end

group :development, :test do
  gem 'rspec-rails', '~>3.8.0'
end

group :production do
  gem 'fog-aws'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
