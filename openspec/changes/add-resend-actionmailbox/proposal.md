# Change: Add Resend provider to Action Mailbox

## Why
Resend is a commonly used email provider. Action Mailbox currently ships ingresses for Mailgun, Mandrill, Postmark, SendGrid, and direct MTA hooks, but lacks a first-party ingress for Resend. Adding it lets Rails apps receive inbound mail from Resend without custom middleware.

## What Changes
- Add a prebuilt Resend ingress endpoint and routing helper consistent with other Action Mailbox providers.
- Document setup for configuring Resend webhook signing/verification and routing to mailboxes.
- Provide tests and sample configuration to align with existing ingress behavior and security guarantees.

## Impact
- Affected specs: actionmailbox ingress capability (new Resend ingress).
- Affected code: Action Mailbox inbound controllers/routes, ingress verification helpers, guides/docs, tests.
