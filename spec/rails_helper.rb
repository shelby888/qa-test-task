ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

selenium = `/sbin/ip route|awk '/scope/ { print $9 }'`.strip
chrome = /chrome/
devise_mailer = %r(assets/email.css)
testrail =  %r(learntrials.testrail.net)
WebMock.disable_net_connect!(allow_localhost: true, allow: [selenium, chrome, devise_mailer, testrail])

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :selenium_remote_chrome.to_sym do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    desired_capabilities: :chrome,
    url: "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444/wd/hub"
  )
end

Capybara.configure do |config|
  if ENV['SELENIUM_REMOTE_HOST']
    # TODO: try to use something from docker-compose
    ip = `/sbin/ip route|awk '/scope/ { print $9 }'`.strip
    config.server_port = ENV['CAPYBARA_SERVER_PORT']
    config.server_host = ip
    config.default_driver = :selenium_remote_chrome
    Capybara::Screenshot.register_driver(:selenium_remote_chrome) do |driver, path|
      driver.browser.save_screenshot(path)
    end
  end

  config.default_max_wait_time = 20
  config.run_server = true
  config.server { |app, port| Capybara.run_default_server(app, port) }
  config.default_selector = :css
  config.ignore_hidden_elements = true
  config.match = :prefer_exact
  config.visible_text_only = true
end

ActiveSupport::Dependencies.autoload_paths << Rails.root.join('spec', 'support', 'page_objects')
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.tty = true if ENV['SELENIUM_REMOTE_HOST'].present?
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.profile_examples = 0
  config.order = :random
  config.render_views

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
    page.driver.browser.manage.window.maximize
  end

  config.before(:each, job: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each, type: :feature) do
    Capybara.reset_sessions!
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
