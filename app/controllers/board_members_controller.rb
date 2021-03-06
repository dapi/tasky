# frozen_string_literal: true

class BoardMembersController < ApplicationController
  layout false

  helper_method :board

  def new
    render locals: { form: InviteForm.new, invited: board.invites.ordered }
  end

  # rubocop:disable Metrics/AbcSize
  def create
    form = InviteForm.new params.require(:invite_form).permit(:emails)
    if form.valid?
      BatchInviteJob.perform_later(
        account_id: board.account_id,
        board_id: board.id,
        inviter_id: current_user.id,
        emails: form.emails_list
      )
      flash_notice! :invited, count: form.emails_list.count
      redirect_to board_path(board)
    else
      render :new, locals: { form: form, invited: board.invites.ordered }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def index
    render locals: { members: board.members, invited: board.invites.ordered }, layout: 'simple'
  end

  private

  def board
    current_user.available_boards.find params[:board_id]
  end
end
