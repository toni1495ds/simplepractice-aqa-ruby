# frozen_string_literal: true

require_relative 'base_page'

# Page Object for the Tasks section of SimplePractice.
# Provides high-level actions for navigating, creating and completing tasks.
class TasksPage < BasePage
  TASKS_PATH      = '/tasks'
  TASKS_NAV_LINK  = 'a[aria-label="Tasks"]'
  NEW_TASK_BUTTON = 'button.button-link' # visible text: "Add quick task"

  # Open Tasks via left navigation (user-like)
  def open
    # STEP 1 — Wait until the Calendar is visible (proof that login finished)
    page.assert_selector('button', text: /Today/i, wait: 20)

    # STEP 2 — Wait for the Tasks link in the sidebar and click it
    page.find(TASKS_NAV_LINK, wait: 15).click

    # STEP 3 — Confirm we actually landed on the Tasks page
    page.assert_text(/Tasks/i, wait: 10)
  end
  alias visit_tasks open
  alias open_tasks  open

  # QUICK FLOW: Create a new quick task (inline)
  # Click "Add quick task" → type title → Enter → appear in list
  def create_task(title:)
    page.find(NEW_TASK_BUTTON, text: /Add quick task/i, wait: 10).click

    # Input appears right after the button; select the first following text input
    input = page.find(
      :xpath,
      "//button[contains(@class,'button-link')][normalize-space()='Add quick task']/following::input[@type='text'][1]",
      wait: 5
    )
    input.set(title)
    input.send_keys(:enter)

    # Assert the new task is visible in the list
    page.assert_selector('.C5wDG.list-item', text: title, wait: 10)
  end

  # FULL FLOW: Create a new task via "Create task" button (form)
  # Click "Create task" → fill Title + Description → Save → appear in list
  def create_full_task(title:, description:)
    # Open the full-create flow
    page.find('a.button.primary', text: /Create task/i, wait: 10).click

    # Fill the form fields
    page.find('#title', wait: 10).set(title)
    page.find('#description', wait: 10).set(description)

    # Save the task
    page.find('button.button.primary', text: /Save/i, wait: 10).click

    # Assert the new task is visible in the list
    page.assert_selector('.C5wDG.list-item', text: title, wait: 10)
  end

  # Mark the task as completed (checkbox in the same row)
  def complete_task(title)
    row = page.find('.C5wDG.list-item', text: title, wait: 10)

    # The checkbox might be styled; allow clicking via label if needed
    cb = row.find('input[type="checkbox"]', visible: :all)
    cb.check(allow_label_click: true)

    # Assert it disappears from the Incomplete list
    page.has_no_selector?('.C5wDG.list-item', text: title, wait: 5)
  end

  # Switch filter from Incomplete → Completed
  def switch_to_completed
    page.find('button.utility-button-style', text: /Incomplete/i, wait: 10).click
    page.find('button', text: /Completed/i, wait: 10).click
    self
  end

  # Predicate: task visible in the Incomplete list
  def task_in_incomplete?(title)
    page.has_css?('.C5wDG.list-item button.button-link[aria-label="Edit task"]',
                  text: title, wait: 5)
  end

  # Predicate: task present in Completed (click title to expand details and verify banner)
  def task_in_completed?(title)
    row = page.find('.C5wDG.list-item', text: title, wait: 10)
    row.find('button.button-link.is-completed', text: title, wait: 10).click
    page.has_css?('p.completed-at', text: /Task marked as completed/i, wait: 10)
  end

  # Convenience: full verification used by the “all-in-one” flow
  def verify_task_completed(title:)
    switch_to_completed
    have_task_in_completed?(title)
  end
end
