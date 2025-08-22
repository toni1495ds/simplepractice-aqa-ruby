# frozen_string_literal: true

require_relative 'base_page'

# Page Object for the Tasks section of SimplePractice.
# Provides high-level actions for navigating, creating and completing tasks.
class TasksPage < BasePage
  TASKS_PATH      = '/tasks'
  TASKS_NAV_LINK  = 'a[aria-label="Tasks"]'
  NEW_TASK_BUTTON = 'button.button-link' # visible text: "Add quick task"

  # Open Tasks via left navigation (user-like) with robust waits + fallback
  def open
    # Wait until the Calendar is visible (confirmation that login succeeded)
    page.assert_selector('button', text: /Today/i, wait: 20)

    # Explicit wait for the Tasks link in the sidebar
    page.find(TASKS_NAV_LINK, wait: 15).click

    # Final confirmation that we landed on the Tasks page
    page.assert_text(/Tasks/i, wait: 10)
  end
  alias visit_tasks open

  # Create a new quick task: click "Add quick task" → type → Enter
  def create_task(title:)
    page.find(NEW_TASK_BUTTON, text: /Add quick task/i, wait: 10).click

    # Input appears right after the button; select the first following text input
    input = page.find(:xpath,
                      "//button[contains(@class,'button-link')][normalize-space()='Add quick task']/following::input[@type='text'][1]",
                      wait: 5)
    input.set(title)
    input.send_keys(:enter)

    # Confirm it shows up in the list
    page.assert_selector('.C5wDG.list-item', text: title, wait: 10)
  end

  # Mark the task as completed by checking its checkbox in the same row
  def complete_task(title)
    row = page.find('.C5wDG.list-item', text: title, wait: 10)

    # The checkbox may be visually styled; use visible: :all + allow_label_click
    cb = row.find('input[type="checkbox"]', visible: :all)
    cb.check(allow_label_click: true)

    # Ensure it disappears from the Incomplete list
    page.has_no_selector?('.C5wDG.list-item', text: title, wait: 5)
  end

  # Change filter from Incomplete → Completed
  def switch_to_completed
    page.find('button.utility-button-style', text: /Incomplete/i, wait: 10).click
    page.find('button', text: /Completed/i, wait: 10).click
    self
  end

  # Predicate: task visible in Incomplete list
  def have_task_in_incomplete?(title)
    page.has_css?('.C5wDG.list-item button.button-link[aria-label="Edit task"]',
                  text: title, wait: 5)
  end

  # Predicate: task present in Completed (after expanding details)
  def have_task_in_completed?(title)
    row = page.find('.C5wDG.list-item', text: title, wait: 10)
    row.find('button.button-link.is-completed', text: title, wait: 10).click
    page.has_css?('p.completed-at', text: /Task marked as completed/i, wait: 10)
  end

  # Convenience: full verification used en el flujo “todo en uno”
  def verify_task_completed(title:)
    switch_to_completed
    have_task_in_completed?(title)
  end
end
