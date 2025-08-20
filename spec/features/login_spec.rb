require 'spec_helper'
require_relative '../../src/pages/login_page'

RSpec.describe 'Login', type: :feature do
  let(:email)    { ENV.fetch('SIMPLEPRACTICE_EMAIL') }
  let(:password) { ENV.fetch('SIMPLEPRACTICE_PASSWORD') }
  let(:login)    { LoginPage.new }

  it 'logs in and lands on the appointments calendar' do
    # Arrange
    login.visit_url('/users/sign_in')

    # Act
    login.login(email, password)

    # Assert: URL contains /calendar/appointments (ignore domain & query)
    expect(page).to have_current_path(%r{/calendar/appointments}, wait: 15, ignore_query: true)

    # Assert 2: the Calendar UI is visible (button 'Today' present)
    # Capybara matches <button> by its visible text
    expect(page).to have_button('Today', wait: 10)
  end
end
