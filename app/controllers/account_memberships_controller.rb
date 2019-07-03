# frozen_string_literal: true

class AccountMembershipsController < ApplicationController
  def destroy
    account = current_user.accounts.find params[:account_id]
    membership = account.memberships.find params[:id]
    membership.destroy!
  end
end
