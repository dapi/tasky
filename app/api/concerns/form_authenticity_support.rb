# frozen_string_literal: true

module FormAuthenticitySupport
  ## ActionController::RequestForgeryProtection::ProtectionMethods::NullSession
  # Sets the token value for the current session.
  #
  def form_authenticity_token
    masked_authenticity_token(session)
  end

  def real_csrf_token(session)
    session[:_csrf_token] ||= SecureRandom.base64(AUTHENTICITY_TOKEN_LENGTH)
    Base64.strict_decode64(session[:_csrf_token])
  end

  # Creates a masked version of the authenticity token that varies
  # on each request. The masking is used to mitigate SSL attacks
  # like BREACH.
  def masked_authenticity_token(session)
    one_time_pad = SecureRandom.random_bytes(AUTHENTICITY_TOKEN_LENGTH)
    encrypted_csrf_token = xor_byte_strings(one_time_pad, real_csrf_token(session))
    masked_token = one_time_pad + encrypted_csrf_token
    Base64.strict_encode64(masked_token)
  end

  def xor_byte_strings(str1, str2)
    str1.bytes.zip(str2.bytes).map { |(c1, c2)| c1 ^ c2 }.pack('c*')
  end
end
