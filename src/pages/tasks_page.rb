# frozen_string_literal: true

require_relative 'base_page'

# Page Object for the Tasks section of SimplePractice.
# Covers: open Tasks, create a quick task, complete it, and verify in Completed.
class TasksPage < BasePage
  TASKS_PATH      = '/tasks'
  TASKS_NAV_LINK  = 'a[aria-label="Tasks"]'
  NEW_TASK_BUTTON = 'button.button-link' # visible text: "Add quick task"

  def open
    # Wait until the Tasks nav link exists
    link = page.find(TASKS_NAV_LINK, wait: 10)
    link.click

    # Validate we actually landed in Tasks
    page.assert_text(/Tasks/i, wait: 10)
  end

  # Create a new quick task: click "Add quick task" → type → Enter
  def create_task(title:)
    page.find(NEW_TASK_BUTTON, text: /Add quick task/i, wait: 10).click

    # Pick the first text input that appears right after the button
    input = page.find(:xpath,
                      "//button[contains(@class,'button-link')][normalize-space()='Add quick task']/following::input[@type='text'][1]", wait: 5)
    input.set(title)
    input.send_keys(:enter)

    # Confirm it shows up in the list
    page.assert_selector('.C5wDG.list-item', text: title, wait: 10)
  end

  # Mark the task as completed by checking its checkbox in the same row
  def complete_task(title:)
    row = page.find('.C5wDG.list-item', text: title, wait: 10)

    # The checkbox may be visually styled; use visible: :all + allow_label_click
    cb = row.find('input[type="checkbox"]', visible: :all)
    cb.check(allow_label_click: true)

    # Ensure it disappears from the Incomplete list
    page.has_no_selector?('.C5wDG.list-item', text: title, wait: 5)
  end

  # Switch filter to "Completed" and verify the task is listed as completed
  def verify_task_completed(title:)
    # Change filter from Incomplete → Completed
    page.find('button.utility-button-style', text: /Incomplete/i, wait: 10).click
    page.find('button', text: /Completed/i, wait: 10).click

    # Find the row of our completed task
    row = page.find('.C5wDG.list-item', text: title, wait: 10)

    # Click the task title (button with .is-completed)
    row.find('button.button-link.is-completed', text: title, wait: 10).click

    # Now the confirmation message should be visible
    page.assert_selector('p.completed-at', text: /Task marked as completed/i, wait: 10)
  end
end
