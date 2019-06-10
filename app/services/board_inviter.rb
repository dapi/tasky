# frozen_string_literal: true

class BoardInviter
  def initialize(board:, email:, inviter:)
    @board = board
    @email = email
    @inviter = inviter
  end

  def perform!
    board_invite = create_board_invite
    InviteMailer
      .invite_to_board(board_invite)
      .deliver_later!

    board_invite
  end

  private

  delegate :account, to: :board

  attr_reader :board, :email, :inviter

  def create_board_invite
    account.with_lock do
      account_invite = account.invites
                              .create_with!(inviter: inviter)
                              .find_or_create_by!(email: email)

      account_invite
        .board_invites
        .create_with!(inviter: inviter)
        .find_or_create_by!(invite: account_invite, board: board)
    end
  end
end
