# frozen_string_literal: true

class AccountMembersController < ApplicationController
  layout 'simple'

  def new
    render locals: { form: InviteForm.new, invited: current_account.invites.ordered }
  end

  # rubocop:disable Metrics/AbcSize
  def create
    form = InviteForm.new params.require(:invite_form).permit(:emails)
    if form.valid?
      BatchInviteJob.perform_later(
        account_id: current_account.id,
        inviter_id: current_user.id,
        emails: form.emails_list
      )
      flash_notice! :invited, count: form.emails_list.count
      redirect_to account_root_url(subdomain: current_account.subdomain)
    else
      render :new, locals: { form: form }
    end
  end
  # rubocop:enable Metrics/AbcSize
end
