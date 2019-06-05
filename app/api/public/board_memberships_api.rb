# frozen_string_literal: true

class Public::BoardMembershipsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Участники досок'
  params do
    requires :board_id, type: String
  end

  helpers do
    def current_board
      @current_board = current_user.available_boards.find params[:board_id]
    end
  end

  resources :board_memberships do
    desc 'Список участников'
    get do
      present BoardMembershipSerializer.new current_board.memberships.ordered, include: %i[member board]
    end

    desc 'Добачить участинка к доске'
    params do
      requires :member_id, type: String
    end
    post do
      membership = current_board.memberships.create! member_id: params[:member_id]

      present BoardMembershipSerializer.new membership, include: %i[member board]
    end
  end
end
