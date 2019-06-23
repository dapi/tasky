# frozen_string_literal: true

class Account::InvitesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :invites do
    desc 'Создаем приглашение'
    params do
      requires :email, type: String
    end
    post do
      invite = current_account.invites.create! inviter: current_user, email: params[:email]

      present InviteSerializer.new invite
    end
  end
end
