# frozen_string_literal: true

class BoardChannel < ApplicationCable::Channel
  NAME = 'board'

  def self.update_board(board, cards: nil)
    data = BoardSerializer.new(board, include: %i[ordered_alive_lanes memberships]).as_json
    broadcast_to board, data.merge(event: :updateBoard, cards: cards)
  end

  def self.update_lanes(board)
    update_board board
  end

  def self.update_with_card(board, card)
    update_board board, cards: [CardSerializer.new(card).as_json]
  end

  def subscribed
    board = Board.find params[:id]
    stream_for board
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
