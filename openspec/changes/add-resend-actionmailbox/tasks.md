## 1. Implementation
- [ ] 1.1 Add Resend ingress endpoint/controller and routing helper patterned after existing provider ingresses.
- [ ] 1.2 Implement webhook signature verification and payload parsing for Resend inbound messages.
- [ ] 1.3 Wire Resend payload conversion to `InboundEmail` creation and mailbox routing.
- [ ] 1.4 Add tests covering happy path, invalid signatures, malformed payloads, and mailbox routing.
- [ ] 1.5 Document configuration/setup steps for Resend ingress (guide/README updates) and add changelog entry if required.
- [ ] 1.6 Keep scope focused (no unrelated refactors/cosmetic changes) and align with Rails contributing guidelines on style/API stability; avoid new deps unless compliant with MIT/dependency policy.

## 2. Validation
- [ ] 2.1 Run relevant Action Mailbox test suite and linters.
- [ ] 2.2 Validate OpenSpec change with `openspec validate add-resend-actionmailbox-ingress --strict`.
