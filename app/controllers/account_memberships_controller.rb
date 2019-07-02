# frozen_string_literal: true

class AccountMembershipsController < ApplicationController
  def destroy
    membership = current_account.memberships.find params[:id]
    membership.destroy!
  end
end
