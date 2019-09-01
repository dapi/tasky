# frozen_string_literal: true

class BoardsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def account
      @account ||= current_user.accounts.find params[:account_id]
    end
  end

  params do
    requires :account_id, type: String
  end

  resources :boards do
    params do
      optional_metadata_query
      optional_include BoardSerializer
    end
    get do
      present BoardSerializer.new by_metadata(account.boards.ordered), include: jsonapi_include
    end

    params do
      requires :title, type: String
      optional_metadata
    end
    post do
      board = BoardCreator
              .new(account)
              .perform(
                attrs: { title: params[:title], metadata: parsed_metadata },
                owner: current_user
              )

      present BoardSerializer.new board
    end

    params do
      requires :id, type: String
    end
    resource ':id' do
      helpers do
        def board
          @board ||= account.boards.find params[:id]
        end
      end
      params do
        optional :title, type: String
        optional_metadata
      end
      put do
        attrs = {}
        attrs[:metadata] = parsed_metadata if params[:metadata].present?
        attrs[:title] = params[:title] if params[:title].present?
        board.update! attrs
        present BoardSerializer.new board
      end
    end
  end
end
