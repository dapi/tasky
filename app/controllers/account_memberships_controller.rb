# frozen_string_literal: true

class AccountMembershipsController < ApplicationController
  layout false
  before_action :xhr_only!

  helper_method :account

  def new
    render locals: { form: InviteForm.new, invited: account.invites.ordered }
  end

  def create
    if form.valid?
      make_invites
      flash_notice! :invited, count: form.emails_list.count
      redirect_to accounts_url
    else
      render :new, locals: { form: form, invited: account.invites.ordered }
    end
  end

  def destroy
    membership = account.memberships.find params[:id]
    membership.destroy!
  end

  private

  def account
    @account ||= current_user.accounts.find params[:account_id]
  end

  def form
    @form ||= InviteForm.new params.require(:invite_form).permit(:emails)
  end

  def make_invites
    BatchInviteJob.perform_later(
      account_id: account.id,
      inviter_id: current_user.id,
      emails: form.emails_list
    )
  end
end
