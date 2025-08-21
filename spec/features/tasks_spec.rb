# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../src/pages/login_page'
require_relative '../../src/pages/tasks_page'
require_relative "../support/test_data"

RSpec.describe 'Tasks feature', type: :feature do
  let(:email)    { ENV.fetch('SIMPLEPRACTICE_EMAIL') }
  let(:password) { ENV.fetch('SIMPLEPRACTICE_PASSWORD') }
  let(:title)    { TestData.task_title } # ahora sale del helper

  it 'creates and completes a task successfully' do
    login_page = LoginPage.new
    login_page.visit_url('/users/sign_in')
    login_page.login(email, password)

    tasks = TasksPage.new
    tasks.open

    tasks.create_task(title: title)
    expect(page).to have_text(title)

    expect(tasks.complete_task(title: title)).to be true

    tasks.verify_task_completed(title: title)
  end
end
