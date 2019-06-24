# frozen_string_literal: true

class Public::API < Grape::API
  default_format :json
  version 'v1'

  include ErrorHandlers
  include SessionSupport
  include ApiHelpers

  before do
    header 'Access-Control-Allow-Origin', '*'
    authorize_user!
  end

  mount Public::UsersAPI
  mount Public::AccountsAPI

  add_swagger_documentation(
    array_use_braces: true,
    doc_version: '0.1.2',
    info: {
      title: 'Tasky Common API',
      description: 'Общее API. Стандарты: https://jsonapi.org'
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
