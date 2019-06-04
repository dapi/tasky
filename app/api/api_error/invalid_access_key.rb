# frozen_string_literal: true

class ApiError::InvalidAccessKey < ApiError::Base
  def status
    401
  end
end
