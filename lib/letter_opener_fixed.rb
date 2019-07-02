# frozen_string_literal: true

# Suppress message opening in development
module LetterOpenerFixed
  class DeliveryMethod < LetterOpener::DeliveryMethod
    def deliver!(mail)
      validate_mail!(mail)
      location = File.join(settings[:location], "#{Time.now.to_f.to_s.tr('.', '_')}_#{Digest::SHA1.hexdigest(mail.encoded)[0..6]}")

      LetterOpener::Message.rendered_messages(mail, location: location, message_template: settings[:message_template])
    end
  end
end
