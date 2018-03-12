module CapybaraWaiters
  def wait_until(timeout = Capybara.default_max_wait_time + 10)
    Timeout.timeout(timeout) do
      loop until yield
    end
  end

  def do_with_hidden_element
    orig = Capybara.ignore_hidden_elements
    Capybara.ignore_hidden_elements = false
    yield
    ensure
    Capybara.ignore_hidden_elements = orig
  end

  def get_errors_for_ci
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.any?
      puts '-------------------------------------------------------------'
      puts "Found #{errors.length} errors"
      puts '-------------------------------------------------------------'
      errors.each do |error|
        puts error.message
        puts '-------------------------------------------------------------'
      end
    end
  end
end
