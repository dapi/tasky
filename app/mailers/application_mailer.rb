# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: Settings.mailer.from
  layout 'mailer'
end
