require "capybara/rspec"
require "selenium-webdriver"

HEADLESS = ENV.fetch("HEADLESS", "true") == "true"

Capybara.default_max_wait_time = 10
Capybara.save_path = "tmp/capybara"

Capybara.register_driver :selenium_chrome do |app|
  opts = Selenium::WebDriver::Chrome::Options.new
  opts.add_argument("--window-size=1440,900")
  opts.add_argument("--disable-gpu")
  opts.add_argument("--no-sandbox")
  opts.add_argument("--disable-dev-shm-usage")
  opts.add_argument("--disable-notifications")
  opts.add_argument("--disable-infobars")
  opts.add_argument("--start-maximized")
  opts.add_argument("--headless=new") if HEADLESS

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
end

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome