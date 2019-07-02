# frozen_string_literal: true

module RescueErrors
  extend ActiveSupport::Concern

  included do
    # rescue_from ActionController::UnknownFormat,     with: :rescue_unknown_format
    # rescue_from Authority::SecurityViolation,        with: :rescue_security_violation
    rescue_from ActionController::MissingFile,       with: :not_found
    rescue_from ActiveRecord::RecordNotFound,        with: :not_found
    rescue_from NotAuthenticated,                    with: :not_authenticated
    rescue_from HumanizedError,                      with: :handle_humanized_error
    rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_invalid_authenticity_token
  end

  private

  def handle_humanized_error(exception)
    render 'exception', locals: { exception: exception }, layout: 'simple'
  end

  def rescue_error(exception)
    render 'exception', locals: { exception: exception }, layout: 'simple'
  end

  def rescue_security_violation(exception)
    return render_json_exception exception, status: :forbidden if request.format.json?

    render 'not_authorized', locals: { exception: exception }, layout: 'simple', status: :forbidden
  end

  def rescue_invalid_authenticity_token
    render 'sessions/new', locals: {
      user_session: UserSession.new,
      message: t('helpers.invalid_authenticity_token')
    }, layout: 'simple'
  end

  def render_json_exception(exception, status: :unprocessable_entity)
    render json: [exception.message], status: status
  end

  def not_found(_exception = nil)
    if request.format.html?
      render 'not_found', status: :not_found, layout: 'simple', formats: [:html]
    else
      render plain: 'not found', status: :not_found, layout: nil, formats: [:text]
    end
  end

  def not_authenticated
    if request.format.json?
      render_json_exception exception, status: :forbidden
    else
      render 'sessions/new', locals: { user_session: UserSession.new, message: t('flashes.not_authenticated') },
                             status: :unauthorized,
                             layout: 'simple'
    end
  end
end
