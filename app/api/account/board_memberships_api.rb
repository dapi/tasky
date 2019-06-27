# frozen_string_literal: true

class Account::BoardMembershipsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def current_board
      @current_board = current_user.available_boards.find params[:board_id]
    end
  end

  params do
    requires :board_id, type: String
  end
  resources :board_memberships do
    get do
      present BoardMembershipSerializer.new current_board.memberships.ordered, include: %i[member]
    end

    params do
      requires :member_id, type: String
    end
    post do
      membership = current_board.memberships.create! member_id: params[:member_id]

      present BoardMembershipSerializer.new membership, include: %i[member]
    end
  end
end
