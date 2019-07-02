# frozen_string_literal: true

class BoardMembersController < ApplicationController
  helper_method :board
  layout 'simple'

  def new
    render locals: { form: BoardInviteForm.new }
  end

  # rubocop:disable Metrics/AbcSize
  def create
    form = BoardInviteForm.new params.require(:board_invite_form).permit(:emails)
    if form.valid?
      BatchInviteJob.perform_later(
        account_id: current_account.id,
        board_id: board.id,
        inviter_id: current_user.id,
        emails: form.emails_list
      )
      flash_notice! :invited, count: form.emails_list.count
      redirect_to board_path(board)
    else
      render :new, locals: { form: form }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def index
    render locals: { members: board.members, board_invites: board.invites }
  end

  private

  def board
    current_user.available_boards.find params[:board_id]
  end
end
