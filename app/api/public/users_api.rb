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

    desc 'Создаем пользователя'
    params do
      requires :email, type: String
    end
    post do
      user = User.create! email: params[:email]

      present UserSerializer.new user
    end
  end
end
