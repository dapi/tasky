# frozen_string_literal: true

class Public::InvitesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Приглашения'
  params do
    requires :account_id, type: String
  end
  resources '/accounts/:account_id' do
    helpers do
      def current_account
        @current_account = current_user.accounts.find(params[:account_id]) || raise('No account found or available for this user')
      end
    end

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
end
