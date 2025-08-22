# frozen_string_literal: true

require 'dotenv/load' # load .env early

# Autoload everything under spec/support (capybara.rb, test_data.rb, etc.)
Dir[File.join(__dir__, 'support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Save artifacts on failure for feature specs (screenshots + HTML)
  config.after(:each, type: :feature) do |example|
    next unless example.exception

    ts   = Time.now.strftime('%Y%m%d-%H%M%S')
    name = example.metadata[:full_description].gsub(/[^\w]+/, '_')[0, 80]

    begin
      # rubocop:disable Lint/Debugger
      save_screenshot("failure_#{name}_#{ts}.png", full: true)
      save_page("failure_#{name}_#{ts}.html")
      # rubocop:enable Lint/Debugger
    rescue StandardError
      # ignore failures when saving artifacts
    end
  end
end
