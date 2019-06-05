# frozen_string_literal: true

class Public::API < Grape::API
  default_format :json
  version 'v1'

  include ErrorHandlers
  include SessionSupport

  helpers do
    include PaginationMeta

    def strict_hash(hash)
      # TODO: Удалять чувствительную информацию, пароли и тп
      hash.reject { |_k, v| v.blank? }
    end
  end

  mount Public::UsersAPI
  mount Public::AccountsAPI
  mount Public::InvitesAPI
  mount Public::BoardsAPI
  mount Public::BoardMembershipsAPI
  mount Public::LanesAPI

  add_swagger_documentation(
    doc_version: '0.1.1',
    info: {
      title: 'Tasky Public API',
      description: 'Публичное API. Стандарты: https://ru.wikipedia.org/wiki/REST, https://jsonapi.org'
    },
    security_definitions: {
      api_key: {
        type: 'apiKey',
        name: SessionSupport::ACCESS_KEY,
        in: 'header'
      }
    }
  )
end
