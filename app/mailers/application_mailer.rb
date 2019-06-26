# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.from
  layout 'mailer'
end
