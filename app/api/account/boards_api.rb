# frozen_string_literal: true

class Account::BoardsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :boards do
    params do
      optional_metadata_query
      optional_include BoardSerializer
    end
    get do
      present BoardSerializer.new by_metadata(current_account.boards.ordered), include: jsonapi_include
    end

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

    params do
      requires :id, type: String
    end
    resource ':id' do
      helpers do
        def board
          @board ||= current_account.boards.find params[:id]
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
