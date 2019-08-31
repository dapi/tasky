# frozen_string_literal: true

class AccountInvitesController < ApplicationController
  def destroy
    invite = current_user.available_invites.find params[:id]
    invite.destroy!
  end
end
