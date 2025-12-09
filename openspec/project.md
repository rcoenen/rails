# Project Context

## Purpose
Core Ruby on Rails framework monorepo targeting Rails 8.2.0.alpha. Hosts the source for all first‑party Rails components (Active Record, Action Pack, Action Mailer, Action Mailbox, Active Storage, Action Text, Active Job, Action Cable, Active Support, Railties) plus their test suites and build tooling.

## Tech Stack
- Ruby (>= 3.2) with Bundler-managed gems per component
- Rails component gems (Active Record, Action Pack, Action Mailer, Action Mailbox, Active Storage, Action Text, Active Job, Action Cable, Active Support, Railties)
- Minitest for Ruby tests; Capybara + Selenium for system/browser tests
- Node + Yarn workspaces for JS packages (Action Cable client, Active Storage JS, Action Text); Rollup/Karma for bundling/tests
- Standard web stacks supported by Rails (Rack, Sprockets/Propshaft, Stimulus/Turbo, JS/CSS bundling adapters)

## Project Conventions

### Code Style
- Ruby style enforced via `.rubocop.yml` (Rails Omakase cops, performance/packaging/minitest/md extensions); follow upstream Rails naming and API conventions from CONTRIBUTING.
- Tests live alongside components under `*/test/`; prefer Minitest assertions (`assert`, `assert_equal`, `assert_not`).
- JavaScript follows the existing package tooling (ES modules, linted by package configs) with minimal dependencies.

### Architecture Patterns
- Monorepo with one gem per component under top-level directories (e.g., `activejob`, `actionmailbox`), each shipping as an independent gem but designed to interoperate through Railties.
- Components follow Rails MVC and engine patterns; Action Mailbox ingresses route inbound email to mailbox classes; Active Storage handles blob/attachment lifecycles; Action Cable provides WebSocket channels.
- Shared tooling lives in `railties` and `tools/`; JS packages mirror their Ruby counterparts for client functionality.

### Testing Strategy
- Primary test runner is `bin/test` (Minitest) scoped per component; use component-specific tasks when iterating (e.g., `bundle exec ruby -Itest path/to/test.rb`).
- Feature/system coverage uses Capybara with Selenium where browser interaction is required.
- JS packages use Yarn-driven builds/tests (e.g., Karma + Rollup in `actioncable`, `activestorage`, `actiontext`); keep JS tests in sync with Ruby behavior.
- New behavior should include matching tests; avoid cosmetic-only changes without coverage.

### Git Workflow
- Default branch: `main`; contributions via feature branches and GitHub pull requests.
- Follow CONTRIBUTING guidance: gather consensus for new features, avoid cosmetic-only changes, and reference issues/discussions when applicable.
- Keep commits focused and reviewable; maintainers use Buildkite for CI.

## Domain Context
- Rails is a full-stack web framework: HTTP routing/controllers, Active Record ORM for multiple databases, background jobs, mail delivery/reception, file storage, WebSockets, and rich text.
- Action Mailbox handles inbound email via provider ingresses (Mailgun, Mandrill, Postmark, SendGrid, Exim/Postfix/Qmail) and routes messages to mailbox classes backed by Active Record/Active Storage.
- Active Storage integrates with cloud/local storage; Action Text builds on Active Storage and Trix for rich text.

## Important Constraints
- Maintain compatibility across officially supported Ruby versions (>= 3.2) and supported databases/adapters (PostgreSQL, MySQL, SQLite, etc.).
- Preserve public API stability and backward compatibility expected of Rails releases; avoid introducing new dependencies without justification.
- MIT-licensed project; ensure third-party additions are compatible with the license.
- CI/build scripts assume Bundler/Yarn toolchain; avoid breaking component gem boundaries.

## External Dependencies
- Rubygems.org for gem distribution; npm/Yarn for JS packages.
- Optional service integrations exercised by components: SMTP and cloud email providers for Action Mailer/Mailbox (Mailgun, Mandrill, Postmark, SendGrid), cloud storage services for Active Storage (S3, GCS, Azure), Rack middleware ecosystem, and job adapters (Solid Queue, Sidekiq, etc.).
- Buildkite CI pipelines for upstream validation.
