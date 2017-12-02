require "capybara-screenshot/spinach"

Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 10

Capybara.register_driver :selenium do |app|
  options = {
    browser: :remote,
    desired_capabilities: :chrome,
  }

  Capybara::Selenium::Driver.new(app, options).tap do |driver|
    screen_size = [1366, 768]
    driver.browser.manage.window.size = Selenium::WebDriver::Dimension.new(*screen_size)
  end
end
