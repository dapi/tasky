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

    def parsed_metadata
      Oj.load params[:metadata].to_s
    rescue Oj::ParseError => e
      Rails.logger.error "#{e} (#{params[:metadata]})"
    end

    def by_metadata(scope)
      metadata = params[:metadata]
      return scope unless metadata.is_a? Hash

      scope.by_metadata metadata.dig(:operator), JSON.parse(metadata.dig(:query))
    end

    def jsonapi_include
      params[:include].to_s.split(',').map(&:squish).compact.uniq
    end
  end

  mount Public::UsersAPI
  mount Public::AccountsAPI
  mount Public::InvitesAPI
  mount Public::BoardsAPI
  mount Public::BoardMembershipsAPI
  mount Public::LanesAPI
  mount Public::TasksAPI
  mount Public::CardsAPI
  mount Public::TaskCommentsAPI

  add_swagger_documentation(
    array_use_braces: true,
    doc_version: '0.1.1',
    api_documentation: { desc: 'Reticulated splines API swagger-compatible documentation.' },
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
