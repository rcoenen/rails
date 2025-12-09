# Change: Add Resend demo app for Action Mailbox

## Why
We need a minimal Rails app to exercise the new Resend ingress end-to-end, show how to configure secrets, and provide a reproducible way to test webhook handling outside the Rails test suite.

## What Changes
- Create a lightweight Rails demo app (kept in-repo) configured with `config.action_mailbox.ingress = :resend`, local storage, and inline job adapter.
- Add a sample mailbox/routing plus a README with setup/run instructions and a curl fixture to post a signed Resend webhook payload.
- Ensure the demo app depends on this repository’s Action Mailbox code (path/git) and avoids external services beyond Resend webhooks.

## Impact
- Affected specs: new Resend demo capability.
- Affected code: demo app directory (bin/rails app), sample mailbox, fixtures/docs.
