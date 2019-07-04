# frozen_string_literal: true

class BoardNotifyJob < ApplicationJob
  def perform(board_id)
    board = Board.find board_id

    BoardChannel.broadcast_to(board, BoardPresenter.new(board).data)
  end
end
