# frozen_string_literal: true

# BasePage is the parent class that provides
# common helper methods for all page objects.
class BasePage
  # Shortcut to Capybara's current session
  def page
    Capybara.current_session
  end

  # Visit by path
  def visit_url(path = '/')
    base = ENV['SIMPLEPRACTICE_BASE_URL']
    page.visit("#{base}#{path}")
  end

  # Generic click by visible text (tries button, then link)
  def click_by_text(text)
    page.click_button(text, exact: false)
  rescue Capybara::ElementNotFound
    page.click_link(text, exact: false)
  end
end
