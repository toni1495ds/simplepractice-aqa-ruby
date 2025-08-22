# frozen_string_literal: true

require 'spec_helper'
require_relative '../../src/pages/login_page'
require_relative '../../src/pages/tasks_page'

RSpec.describe 'Tasks feature', type: :feature do
  let(:email)    { ENV.fetch('SIMPLEPRACTICE_EMAIL') }
  let(:password) { ENV.fetch('SIMPLEPRACTICE_PASSWORD') }
  let(:login)    { LoginPage.new }
  let(:tasks)    { TasksPage.new }
  let(:title)    { TestData.task_title } # comes from spec/support/test_data.rb

  it 'creates and completes a task successfully' do
    # STEP 1: Log into the application
    login.visit_login
    login.login_as(email, password)

    # STEP 2: Navigate to Tasks
    tasks.visit_tasks

    # STEP 3: Create a new task with a unique title
    tasks.create_task(title: title)

    # STEP 4: Verify task appears in "Incomplete"
    expect(tasks.have_task_in_incomplete?(title)).to be true

    # STEP 5: Mark task as completed
    expect(tasks.complete_task(title)).to be true

    # STEP 6: Switch to "Completed" filter and verify
    tasks.switch_to_completed
    expect(tasks.have_task_in_completed?(title)).to be true
  end
end
