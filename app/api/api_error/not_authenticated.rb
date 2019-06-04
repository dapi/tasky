# frozen_string_literal: true

class ApiError::NotAuthenticated < ApiError::Base
  def status
    401
  end
end
