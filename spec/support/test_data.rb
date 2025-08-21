# frozen_string_literal: true

require 'securerandom'

# Centralized test data factory
module TestData
  # Returns a short, unique task title
  def self.task_title(prefix: 'AQA Task')
    "#{prefix} #{SecureRandom.hex(4)}"
  end
end
