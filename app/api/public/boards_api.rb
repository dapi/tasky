# frozen_string_literal: true

class Public::BoardsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Доски'
  params do
    requires :account_id, type: String
  end
  resources '/accounts/:account_id' do
    helpers do
      def current_account
        @current_account = current_user.accounts.find params[:account_id]
      end
    end

    resources :boards do
      desc 'Список доступных досок'
      params do
        optional_metadata_query
        optional_include BoardSerializer
      end
      get do
        present BoardSerializer.new by_metadata(current_account.boards.ordered), include: jsonapi_include
      end

      desc 'Создать доску'
      params do
        requires :title, type: String
        optional_metadata
      end
      post do
        board = current_account.boards.create_with_member!(
          { title: params[:title], metadata: parsed_metadata },
          member: current_user
        )

        present BoardSerializer.new board
      end
    end
  end
end
