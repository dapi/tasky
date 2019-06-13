# frozen_string_literal: true

class Public::AccountsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Аккаунты'
  resources :accounts do
    desc 'Список доступных аккаунтов'
    get do
      present AccountSerializer.new current_user.accounts, include: [:owner]
    end

    desc 'Создать аккаунт'
    params do
      requires :name, type: String
      optional :metadata, type: String, desc: 'metadata в JSON формате', default: '{}'
    end
    post do
      account = current_user.owned_accounts.create! name: params[:name], metadata: parsed_metadata

      present AccountSerializer.new account, include: [:owner]
    end
  end
end
