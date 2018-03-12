source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'webpacker'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'capybara', '~> 2.5.0'
  gem 'capybara-angular'
  gem 'capybara-screenshot'
  gem 'chromedriver-helper', '1.0.0'
  gem 'site_prism'
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :test do
  gem 'database_cleaner', '~> 1.3.0'
  gem 'codeclimate-test-reporter', '~> 0.4.0', require: nil
  gem 'api_matchers', '~> 0.6.2'
  gem 'json_expressions', '~> 0.8.3'
  gem 'mock_redis', require: false
  gem 'webmock'
  gem 'fake_stripe'
  gem 'rspec-testrail'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
