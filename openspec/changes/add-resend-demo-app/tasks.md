## 1. Demo App Setup
- [x] 1.1 Scaffold a minimal Rails app under a `demo/` directory (SQLite, Active Storage local, inline Active Job, Action Mailbox installed).
- [x] 1.2 Point the demo app’s Gemfile to this repo’s Rails/Action Mailbox code (path or git branch) and lock dependencies.
- [x] 1.3 Configure Action Mailbox for Resend ingress (`config.action_mailbox.ingress = :resend`), default URL/host, and storage/jobs for local use.

## 2. Demo Behavior
- [x] 2.1 Add a sample mailbox and routing that records inbound messages for inspection (e.g., logs or simple view).
- [x] 2.2 Provide a curl script/fixture that posts a signed Resend webhook payload to the demo ingress path.
- [x] 2.3 Add README/setup instructions covering secrets (`RESEND_INGRESS_SIGNING_SECRET`), running the server, and invoking the fixture.
- [x] 2.4 Include local tunneling guidance (e.g., `npx localtunnel --port 3000`) for exposing the webhook endpoint to Resend during manual tests.

## 3. Validation
- [ ] 3.1 Manually verify the demo app processes the sample webhook end-to-end (inbound email created and mailbox invoked).
- [x] 3.2 Run `openspec validate add-resend-demo-app --strict`.
