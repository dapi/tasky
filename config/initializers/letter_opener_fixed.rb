# frozen_string_literal: true

ActiveSupport.on_load :action_mailer do
  ActionMailer::Base.add_delivery_method(
    :letter_opener_fixed,
    LetterOpenerFixed::DeliveryMethod
  )
end
