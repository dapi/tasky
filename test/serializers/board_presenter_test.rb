# frozen_string_literal: true

require 'test_helper'

class BoardPresenterTest < ActiveSupport::TestCase
  test 'present the board' do
    user = create :user
    board = create :board
    lane = create :lane, board: board
    create :card, lane: lane
    assert BoardPresenter.new(board, user).data
  end
end
