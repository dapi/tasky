module ErrorHandlers
  ERROR_HEADERS = {
    'Content-type' => 'application/vnd.api+json',
    'Cache-Control' => 'no-cache, no-store, must-revalidate',
    'Pragma' => 'no-cache',
    'Expires' => 0
  }.freeze

  DEFAULT_STATUS = 500

  extend ActiveSupport::Concern

  included do
    #rescue_from ApiError::Base, rescue_subclasses: true do |error|
      #error!(
        #{ errors: [error] },
        #error.status,
        #ERROR_HEADERS,
        #error.backtrace
      #)
    #end

    rescue_from ActiveRecord::RecordInvalid, ActiveModel::ValidationError, rescue_subclasses: true do |error|
      object = (error.respond_to?(:record) ? error.record : error.model)
      errors = object.errors.map do |key, message|
        {
          id: error.object_id,
          code: error.class.name.underscore,
          title: message,
          source: {
            pointer: "/data/attributes/user/#{key}",
            parameter: key
          }
        }
      end

      error!(
        { errors: errors },
        400,
        ERROR_HEADERS,
        error.backtrace
      )
    end

    rescue_from ActiveRecord::RecordNotFound, ActiveModel::RangeError, rescue_subclasses: true do |error|
      error_hash = {
        id: error.object_id,
        code: error.class.name.underscore,
        title: error.message
      }

      code = case error
             when ActiveRecord::RecordNotFound
               404
             else
               400
             end

      error!(
        { errors: [error_hash] },
        code,
        ERROR_HEADERS,
        error.backtrace
      )
    end

    rescue_from StandardError, rescue_subclasses: true do |error|
      status = DEFAULT_STATUS

      # Есть подозрение что тут пропускаются важные ошибки, поэтому пока отключили
      #
      # unless error.is_a?(Grape::Exceptions::Base) || error.is_a?(ActiveRecord::RecordNotFound)
      #
      Bugsnag.notify error
      Rails.logger.error "[#{error.class}] #{error.message}"
      Rails.logger.error error.backtrace.join("\n")

      # TODO: обрабатывать в духе jsonapi
      # ошибки типа Grape::Exceptions::ValidationErrors и Grape::Exceptions::Validation
      # в случае validationErrors - error.instance_variable_get('@errors')
      # => {["captcha"]=>[#<Grape::Exceptions::Validation: is missing>]}
      status = error.status if error.is_a? Grape::Exceptions::Base

      ee = {
        code: error.class.name.underscore,
        status: status.to_s,
        title: error.class.to_s,
        detail: error.message.to_s
      }

      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', 0

      error!(
        { errors: [ee] },
        status,
        ERROR_HEADERS,
        error.backtrace
      )
    end
  end
end
