# frozen_string_literal: true

require 'spec_helper'
require_relative '../../src/pages/login_page'

# Covers the authentication path:
#  1) Open the Sign in page
#  2) Submit valid credentials
#  3) Verify we land on the Appointments calendar
#  4) Verify a key UI control is visible ("Today" button)
RSpec.describe 'Login feature', type: :feature do
  # Test inputs come from environment variables (.env loaded by spec_helper)
  let(:email)    { ENV.fetch('SIMPLEPRACTICE_EMAIL') }
  let(:password) { ENV.fetch('SIMPLEPRACTICE_PASSWORD') }
  let(:login)    { LoginPage.new }

  it 'authenticates and lands on the Appointments calendar' do
    # STEP 1 — Open the Sign in page
    login.visit_login

    # STEP 2 — Submit credentials (happy path)
    login.login_as(email, password)

    # STEP 3 — Assert we are redirected to the Appointments calendar
    expect(page).to have_current_path(%r{/calendar/appointments}, wait: 15, ignore_query: true)

    # STEP 4 — Assert a key calendar control is visible: "Today" button
    expect(page).to have_button('Today', wait: 10)
  end
end
