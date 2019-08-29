# frozen_string_literal: true

module Bugsnag::Middleware
  ##
  # Extracts and attaches user information from Sorcery to an error report
  class SorceryUser
    COMMON_USER_FIELDS = %i[email name first_name last_name created_at id].freeze

    def initialize(bugsnag)
      @bugsnag = bugsnag
    end

    def call(report)
      if report.request_data[:rack_env]
        session = report.request_data[:rack_env].fetch 'rack.session', {}

        if session[:user_id].present?
          user_class = ::Sorcery::Controller::Config.user_class.constantize
          current_user = user_class.sorcery_adapter.find_by_id session[:user_id]

          # Extract useful user information
          user = {}
          if current_user.present?
            # Build the user info for this scope
            COMMON_USER_FIELDS.each do |field|
              user[field] = current_user.send(field) if current_user.respond_to?(field)
            end
          end

          report.user = user unless user.empty?
        end
      end

      @bugsnag.call(report)
    end
  end
end
