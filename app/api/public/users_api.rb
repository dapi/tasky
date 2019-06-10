# frozen_string_literal: true

class Public::UsersAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  desc 'Пользователи'
  resources :users do
    desc 'Информация о текущем пользователе'
    get :me do
      authorize_user!
      present UserSerializer.new current_user, params: { show_private: true }
    end
  end
end
