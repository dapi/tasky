# frozen_string_literal: true

class AccountInvitesController < ApplicationController
  def destroy
    invite = current_account.invites.find params[:id]
    invite.destroy!
  end
end
