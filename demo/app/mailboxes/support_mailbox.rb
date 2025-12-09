class SupportMailbox < ApplicationMailbox
  def process
    Rails.logger.info("[SupportMailbox] Received #{mail.subject.inspect} from #{mail.from&.join(", ")} to #{mail.to&.join(", ")}")
    save_raw_email(mail)
    SupportMessage.create!(
      subject: mail.subject,
      from: mail.from&.join(", "),
      to: mail.to&.join(", "),
      body: safe_body(mail)
    )
  end

  private
    def safe_body(mail)
      if mail.multipart?
        mail.text_part&.decoded.presence || mail.html_part&.decoded.presence || "(empty multipart)"
      else
        mail.decoded
      end
    rescue StandardError => error
      Rails.logger.error("[SupportMailbox] Failed to decode body: #{error.message}")
      "(undecodable body)"
    end

    def save_raw_email(mail)
      dir = Rails.root.join("emails_received")
      FileUtils.mkdir_p(dir)
      timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
      suffix = SecureRandom.hex(4)

      normalized = normalize_mail_for_display(mail)
      File.binwrite(dir.join("#{timestamp}-#{suffix}-normalized.eml"), normalized.encoded)
    rescue StandardError => error
      Rails.logger.error("[SupportMailbox] Failed to persist raw email: #{error.message}")
    end

    def normalize_mail_for_display(mail)
      mixed = Mail.new
      mixed.subject = mail.subject
      mixed.from = mail.from
      mixed.to = mail.to
      mixed.cc = mail.cc
      mixed.bcc = mail.bcc
      mixed.content_type = "multipart/mixed"

      related = Mail::Part.new
      related.content_type = "multipart/related"

      alt = Mail::Part.new
      alt.content_type = "multipart/alternative"
      if mail.multipart?
        alt.add_part(mail.text_part) if mail.text_part
        alt.add_part(mail.html_part) if mail.html_part
      else
        alt.add_part(Mail::Part.new { body mail.decoded; content_type mail.content_type })
      end
      related.add_part(alt)

      mail.attachments.each do |att|
        if att.inline?
          related.attachments[att.filename] = {
            content_type: att.content_type,
            content: att.body.decoded,
            content_id: att.cid
          }
        else
          mixed.attachments[att.filename] = {
            content_type: att.content_type,
            content: att.body.decoded
          }
        end
      end

      mixed.add_part(related)
      mixed
    end
end
