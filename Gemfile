source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.13'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# net-ssh requires the following gems for ed25519 support:
gem 'ed25519', '~> 1.2'
gem 'bcrypt_pbkdf', '~> 1.0'
# As of net-ssh 5.2.0, these are included as development dependencies, but not runtime dependencies.
# See https://github.com/net-ssh/net-ssh/issues/565 for more information

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.5.0'
  gem 'capistrano-bundler', '~> 1.1.4'
  gem 'capistrano-rails', '~> 1.1.7'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# User and role management
gem 'devise', '~> 4.5'
gem 'gravtastic', '~> 3.2.6'
gem 'cancancan', '~> 1.15.0'
gem 'rolify', '~> 5.1.0'

# Shibboleth Single Sign On
gem 'omniauth', '~> 1.3.2'
gem 'omniauth-shibboleth', '~> 1.2.1'

# File management
gem 'paperclip', '~> 5.2.0'

# LDAP libraries
gem 'ruby-ldap'
gem 'activeldap', '~> 5.1', require: 'active_ldap/railtie'
gem 'net-ldap'

# SOAP client for card lookup
gem 'savon', '~> 2.11.1'

# Business date calculations
gem 'business_time', '~> 0.7.6'

# Hierarchical database tables
gem 'ancestry', '~> 3.0.1'
gem 'inherited-attributes', '~> 0.1.1'
