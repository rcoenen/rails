# Resend Action Mailbox Demo

A minimal Rails app to exercise the Resend ingress end-to-end using this repository's Rails/Action Mailbox code.

## Setup

```bash
cd demo
cp .env.example .env
# edit .env with your RESEND_INGRESS_SIGNING_SECRET and optional HOST_URL/RESEND_DEMO_TO

RBENV_VERSION=3.4.7 rbenv exec bundle install
RBENV_VERSION=3.4.7 rbenv exec bundle exec bin/rails db:setup
```

`HOST_URL` defaults to `http://localhost:3000` and is optional for the server (hosts are unrestricted in development). Set it when you want default URL options to match your tunnel or when using the webhook helper script. The demo routes `RESEND_DEMO_TO` (default `mail@support.migrately.nl`) to `SupportMailbox`.

## Run the server

```bash
RBENV_VERSION=3.4.7 rbenv exec bundle exec bin/rails server -p 3000
```

Visit `http://localhost:3000` to see the inbox.

## Expose via tunnel for Resend

If you're behind NAT, expose port 3000:

```bash
npx localtunnel --port 3000
# note the URL (e.g., https://your-subdomain.loca.lt) and export it for the helper script:
export HOST_URL=https://your-subdomain.loca.lt
```

Update `.env` or your shell with the new `HOST_URL` whenever the tunnel changes.

Configure Resend's inbound webhook to POST to:

```
<HOST_URL>/rails/action_mailbox/resend/inbound_emails
```

## Post a sample webhook (local)

Use the helper script to send a signed webhook payload:

```bash
RBENV_VERSION=3.4.7 rbenv exec ruby bin/post_resend_webhook \
  --url "${HOST_URL:-http://localhost:3000}" \
  --to "${RESEND_DEMO_TO:-mail@support.migrately.nl}"
# optional: --secret overrides RESEND_INGRESS_SIGNING_SECRET
# optional: --file path/to/raw.eml to send a custom email
```

Incoming messages are stored in `support_messages` and listed at `/`.
