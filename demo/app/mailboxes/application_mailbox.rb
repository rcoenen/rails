class ApplicationMailbox < ActionMailbox::Base
  routing ENV.fetch("RESEND_DEMO_TO", "mail@support.migrately.nl") => :support
end
