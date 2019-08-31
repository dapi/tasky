# frozen_string_literal: true

class BoardMembershipsController < ApplicationController
  def destroy
    membership = current_user.accounts.board_memberships.find params[:id]
    membership.destroy!
  end
end
