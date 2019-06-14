# frozen_string_literal: true

require 'test_helper'

class CardChangePositionText < ActiveSupport::TestCase
  test 'move second card across lanes' do
    from_lane = create :lane, :with_cards, cards_count: 3
    card = from_lane.cards.ordered.second
    to_lane = create :lane, :with_cards, cards_count: 3
    assert_equal [0, 1, 2], to_lane.cards.ordered.pluck(:position)

    CardChangePosition.new(card).change_position 0, to_lane

    assert_equal card.lane, to_lane
    assert_equal card.reload.position, 0
    assert_equal [0, 1, 2, 3], to_lane.cards.ordered.pluck(:position)
    assert_equal [0, 1], from_lane.cards.ordered.pluck(:position)
  end

  test 'move last card across lanes' do
    from_lane = create :lane, :with_cards, cards_count: 3
    card = from_lane.cards.ordered.last
    to_lane = create :lane, :with_cards, cards_count: 3
    assert_equal [0, 1, 2], to_lane.cards.ordered.pluck(:position)

    CardChangePosition.new(card).change_position 0, to_lane

    assert_equal card.lane, to_lane
    assert_equal card.reload.position, 0
    assert_equal [0, 1, 2, 3], to_lane.cards.ordered.pluck(:position)
    assert_equal [0, 1], from_lane.cards.ordered.pluck(:position)
  end

  test 'move card up' do
    lane = create :lane, :with_cards, cards_count: 3
    card = lane.cards.ordered.last

    CardChangePosition.new(card).change_position 0

    assert_equal 0, card.position
    assert_equal [0, 1, 2], lane.cards.ordered.pluck(:position)
  end

  test 'move card down' do
    lane = create :lane, :with_cards, cards_count: 3
    card = lane.cards.ordered.first

    CardChangePosition.new(card).change_position 2

    assert_equal 2, card.position
    assert_equal [0, 1, 2], lane.cards.ordered.pluck(:position)
  end
end
