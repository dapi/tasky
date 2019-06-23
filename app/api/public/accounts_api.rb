# frozen_string_literal: true

class Public::AccountsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  desc 'Аккаунты', notes: 'Аккаунты это команды :)'
  resources :accounts do
    desc 'Список доступных аккаунтов'
    params do
      optional_metadata_query
      optional_include AccountSerializer
    end
    get do
      present AccountSerializer.new by_metadata(current_user.accounts), include: jsonapi_include
    end

    desc 'Создать аккаунт'
    params do
      requires :name, type: String
      optional_metadata
    end
    post do
      account = current_user.owned_accounts.create! name: params[:name], metadata: parsed_metadata

      present AccountSerializer.new account
    end
  end
end
