# frozen_string_literal: true

require 'test_helper'

class ChangePositionTest < ActiveSupport::TestCase
  test 'move card up' do
    lane = create :lane, :with_cards, cards_count: 3
    card = lane.cards.ordered.last

    ChangePosition.new(card, card.lane).change! 0

    assert_equal 0, card.position
    assert_equal [0, 1, 2], lane.cards.ordered.pluck(:position)
  end

  test 'move card down' do
    lane = create :lane, :with_cards, cards_count: 3
    card = lane.cards.ordered.first

    ChangePosition.new(card, card.lane).change! 2

    assert_equal 2, card.position
    assert_equal [0, 1, 2], lane.cards.ordered.pluck(:position)
  end
end
