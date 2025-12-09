## ADDED Requirements
### Requirement: Resend ingress
Action Mailbox SHALL provide a first-party Resend ingress that accepts Resend inbound webhooks, verifies signatures, rebuilds MIME messages, and creates `InboundEmail` records routed to mailboxes via `routes.rb` mounting, matching conventions of existing provider ingresses.

#### Scenario: Accepts valid Resend webhook
- **WHEN** a Resend webhook with a valid signature posts inbound message data to the mounted ingress path
- **THEN** the request is accepted, the MIME message is reconstructed, an `InboundEmail` record is created, and the email is routed to the configured mailbox.

#### Scenario: Rejects invalid signature
- **WHEN** a Resend webhook arrives with a missing or invalid signature
- **THEN** the request is rejected with a 401-style response and no `InboundEmail` is created.

#### Scenario: Handles malformed payload safely
- **WHEN** a Resend webhook payload is malformed or missing required fields
- **THEN** the ingress responds with a 400-style error and does not create an `InboundEmail`.
