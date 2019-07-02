# frozen_string_literal: true

class BoardMembershipsController < ApplicationController
  def destroy
    membership = current_account.board_memberships.find params[:id]
    membership.destroy!
  end
end
