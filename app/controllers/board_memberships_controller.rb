# frozen_string_literal: true

class BoardMembershipsController < ApplicationController
  def destroy
    membership = BoardMembership.where(board_id: current_user.available_boards.pluck(:id)).find params[:id]
    membership.destroy!
  end
end
