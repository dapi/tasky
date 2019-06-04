# frozen_string_literal: true

class ApiError::Forbidden < ApiError::Base
  def status
    403
  end
end
