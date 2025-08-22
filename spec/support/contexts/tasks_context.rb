# frozen_string_literal: true

require 'securerandom'
require_relative '../../spec_helper'
require_relative '../../../src/pages/login_page'
require_relative '../../../src/pages/tasks_page'

# Common test data and page objects for Tasks specs
RSpec.shared_context 'tasks_context' do
  let(:email)    { ENV.fetch('SIMPLEPRACTICE_EMAIL') }
  let(:password) { ENV.fetch('SIMPLEPRACTICE_PASSWORD') }

  let(:login) { LoginPage.new }
  let(:tasks) { TasksPage.new }

  # Unique titles per run to avoid collisions
  let(:quick_title) { TestData.task_title(prefix: 'AQA Quick Task') }
  let(:full_title)  { TestData.task_title(prefix: 'AQA Full Task') }
  let(:desc)        { "Automated description #{SecureRandom.hex(3)}" }
end
