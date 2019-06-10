# frozen_string_literal: true

class BoardInviter
  def initialize(board:, email:, inviter:)
    @board = board
    @email = email
    @inviter = inviter
  end

  def perform!
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

  private

  delegate :account, to: :board

  attr_reader :board, :email, :inviter
end
