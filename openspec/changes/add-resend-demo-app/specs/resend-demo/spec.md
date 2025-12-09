## ADDED Requirements
### Requirement: Resend demo app
A minimal demo Rails application SHALL be included to demonstrate Action Mailbox Resend ingress end-to-end using local dependencies, with clear setup, routing, and sample webhook invocation.

#### Scenario: Run demo locally
- **WHEN** a developer follows the demo README to set `RESEND_INGRESS_SIGNING_SECRET`, install dependencies, and start the server
- **THEN** the app runs with `config.action_mailbox.ingress = :resend`, local storage, and inline jobs using this repository’s Action Mailbox code.

#### Scenario: Post sample webhook
- **WHEN** the provided curl/fixture posts a signed Resend webhook payload to `/rails/action_mailbox/resend/inbound_emails`
- **THEN** an `InboundEmail` is created and routed to the sample mailbox, and the demo surfaces the processed message (e.g., in logs or a simple view).
