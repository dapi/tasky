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

  resources '/boards/:board_id' do
    helpers do
      def current_board
        @current_board = current_user.available_boards.find params[:board_id]
      end
    end

    resources :memberships do
      desc 'Список участников'
      get do
        present BoardMembershipSerializer.new current_board.memberships.ordered, include: %i[member]
      end

      desc 'Добавить участинка к доске'
      params do
        requires :member_id, type: String
      end
      post do
        membership = current_board.memberships.create! member_id: params[:member_id]

        present BoardMembershipSerializer.new membership, include: %i[member]
      end
    end

    resources :invites do
      desc 'Приглашение в доску по емайлу'
      params do
        requires :email, type: String
      end
      post do
        board_invite = BoardInviter
                       .new(board: current_board, inviter: current_user, email: params[:email])
                       .perform!
        present BoardInviteSerializer.new board_invite
      end
    end
  end
end
