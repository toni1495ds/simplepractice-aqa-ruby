# frozen_string_literal: true

require 'spec_helper'

# This spec validates the "Full Form Task" flow.
# Covers: login → navigate to Tasks → create task with title+description → complete → verify in Completed.
RSpec.describe 'Tasks - Full form flow', type: :feature do
  include_context 'tasks_context'

  it 'creates and completes a task via the Create Task form' do
    # STEP 1 — Log into the application
    login.visit_login
    login.login_as(email, password)

    # STEP 2 — Navigate to Tasks via the sidebar (user-like)
    tasks.visit_tasks

    # STEP 3 — Create a full task (Title + Description) and save
    tasks.create_full_task(title: full_title, description: desc)

    # STEP 4 — Verify it appears in "Incomplete"
    expect(tasks.task_in_incomplete?(full_title)).to be true

    # STEP 5 — Complete the task
    expect(tasks.complete_task(full_title)).to be true

    # STEP 6 — Switch to "Completed" filter and verify
    tasks.switch_to_completed
    expect(tasks.task_in_completed?(full_title)).to be true
  end
end
