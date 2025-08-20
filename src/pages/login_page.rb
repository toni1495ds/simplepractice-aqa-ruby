# frozen_string_literal: true

require_relative 'base_page'

# LoginPage models the login screen of SimplePractice
# and provides methods to interact with it.
class LoginPage < BasePage
  # Locators
  EMAIL_FIELD = '#user_email'
  PASSWORD_FIELD = '#user_password'
  SIGN_IN_BUTTON = '#submitBtn'

  # Fill email
  def fill_email(email)
    page.find(EMAIL_FIELD).set(email)
  end

  # Fill password
  def fill_password(password)
    page.find(PASSWORD_FIELD).set(password)
  end

  # Click Sign in
  def submit
    page.find(SIGN_IN_BUTTON).click
  end

  # High-level action: login with email + password
  def login(email, password)
    fill_email(email)
    fill_password(password)
    submit
  end
end
