# SimplePractice AQA Ruby

Automated QA project using **Ruby + RSpec + Capybara**.  
Includes an initial authentication (login) flow for [SimplePractice](https://secure.simplepractice.com).

## Tech Stack

- [Ruby](https://www.ruby-lang.org/)
- [RSpec](https://rspec.info/)
- [Capybara](https://teamcapybara.github.io/capybara/)
- [Selenium WebDriver](https://www.selenium.dev/documentation/webdriver/)

## Project Structure

```bash

spec/
├── features/ # Feature tests (RSpec)
│ ├── login_spec.rb # Login flow
│ ├── tasks_quick_spec.rb # Create task (quick add)
│ └── tasks_full_spec.rb # Create task (full form)
│
├── support/ # Helpers and shared config
│ ├── contexts/
│ │ └── tasks_context.rb # Common context for tasks tests
│ ├── capybara.rb # Capybara driver configuration
│ ├── test_data.rb # Dynamic test data generators
│ └── spec_helper.rb # RSpec global setup (incl. screenshots on failure)
│
src/
└── pages/ # Page Object Models (POM)
├── base_page.rb # Base wrapper for Capybara DSL
├── login_page.rb # Login page actions
└── tasks_page.rb # Tasks page actions (predicates & helpers)

```

## ⚙️ Setup

1. Install dependencies:

   ```bash
   bundle install

   ```

2. Set environment variables in .env (copy from .env.example):
   ```bash
   SIMPLEPRACTICE_EMAIL=your_email
   SIMPLEPRACTICE_PASSWORD=your_password
   ```
3. Run tests:

Entire suite:

```bash
bundle exec rspec
```

Specific file:

```bash
bundle exec rspec spec/features/tasks_quick_spec.rb
```

With browser visible:

```bash
HEADLESS=false bundle exec rspec
```

## Features Covered

### Login flow

- Validates authentication with environment credentials.

### Tasks

- Create task via Quick Add.
- Create task via Full Form.
- Verify presence in Incomplete.
- Move to Completed and assert banner confirmation.

### Artifacts on Failure

Automatically saves:

- `failure_<name>_<timestamp>.png` (screenshot)
- `failure_<name>_<timestamp>.html` (page source)

## Best Practices Applied

- **Page Object Model (POM):** keeps locators & actions encapsulated.
- **Contexts:** reusable login/session setup.
- **Predicates (? methods):** for readable expectations (e.g., `task_in_incomplete?`).
- **Unique test data:** avoids collisions across runs.
- **Rubocop linting:** ensures clean & consistent Ruby code.

## Example Run

```bash
HEADLESS=false bundle exec rspec spec/features/tasks_spec.rb
```

## Output

```bash
...
Finished in 36.8 seconds (files took 0.99426 seconds to load)
3 examples, 0 failures
```

## Test Checklists

- [Tasks Happy Path Checklist](./TASKS_CHECKLIST.md): Exploratory test scenarios covering creation, completion, filters, and sorting of tasks.
