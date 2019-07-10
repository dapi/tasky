# frozen_string_literal: true

class BoardChannel < ApplicationCable::Channel
  NAME = 'board'

  def self.update_board(board)
    data = BoardSerializer.new(board, include: %i[ordered_alive_lanes memberships]).as_json
    broadcast_to board, data.merge(event: :updateBoard)
  end

  def self.update_lanes(board)
    update_board board
  end

  def self.update_with_card(board, card)
    data = BoardSerializer.new(board, include: %i[ordered_alive_lanes memberships]).as_json
    broadcast_to board, data.merge(event: :updateBoard, cards: [CardSerializer.new(card).as_json])
  end

  def subscribed
    board = Board.find params[:id]
    stream_for board
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
