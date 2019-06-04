# frozen_string_literal: true

class Public::API < Grape::API
  default_format :json

  version 'v1'

  # include ApiSession
  # include ErrorHandlers

  # helpers do
  # include PaginationMeta

  # def strict_hash(hash)
  ## TODO: Удалять чувствительную информацию, пароли и тп
  # hash.reject { |_k, v| v.blank? }
  # end

  # def require_non_tech_break!
  # raise ApiError::Forbidden.new(title: I18n.t('api_errors.tech_break.title')) if BreaksService.active?
  # end
  # end
  add_swagger_documentation(
    info: {
      title: 'Tasky Public API'
    }
  )
end
