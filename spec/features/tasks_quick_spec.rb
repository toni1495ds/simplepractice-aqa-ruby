# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Tasks – Quick flow', type: :feature do
  include_context 'tasks_context'

  it 'creates and completes a task via the Quick Task flow' do
    # STEP 1 — Log into the application
    login.visit_login
    login.login_as(email, password)

    # STEP 2 — Navigate to Tasks via the sidebar (user-like)
    tasks.visit_tasks

    # STEP 3 — Create a new quick task (inline)
    tasks.create_task(title: quick_title)

    # STEP 4 — Verify it appears in "Incomplete"
    expect(tasks.task_in_incomplete?(quick_title)).to be true

    # STEP 5 — Complete the task
    expect(tasks.complete_task(quick_title)).to be true

    # STEP 6 — Switch to "Completed" filter and verify
    tasks.switch_to_completed
    expect(tasks.task_in_completed?(quick_title)).to be true
  end
end
