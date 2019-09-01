# frozen_string_literal: true

class UsersAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :users do
    get :me do
      present UserSerializer.new current_user, params: { show_private: true }
    end
  end
end
