# frozen_string_literal: true

class BoardNotifyJob < ApplicationJob
  def perform(board_id)
    board = Board.find board_id

    BoardChannel.update_board board
  end
end
