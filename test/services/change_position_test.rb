# frozen_string_literal: true

require 'test_helper'

class ChangePositionTest < ActiveSupport::TestCase
  test 'move card up' do
    lane = create :lane, :with_cards, cards_count: 3
    card = lane.cards.ordered.last

    ChangePosition.new(card.lane).change! card, 0

    assert_equal 0, card.position
    assert_equal [0, 1, 2], lane.cards.ordered.pluck(:position)
  end

  # [0,1,2] 0 -> 2
  test 'move top card bottom' do
    lane = create :lane, :with_cards, cards_count: 3
    card = lane.cards.ordered.first

    ChangePosition.new(card.lane).change! card, 2

    assert_equal 2, card.position
    assert_equal lane.cards.ordered.last, card
    assert_equal [0, 1, 2], lane.cards.ordered.pluck(:position)
  end

  test 'move up card bottom [0,1,2,3] 1 -> 3' do
    lane = create :lane, :with_cards, cards_count: 4
    card = lane.cards.ordered.second

    ChangePosition.new(card.lane).change! card, 3

    assert_equal 3, card.position
    assert_equal lane.cards.ordered.last, card
    assert_equal [0, 1, 2, 3], lane.cards.ordered.pluck(:position)
  end

  test 'move card down by one [0,1,2,3] 1 -> 2' do
    lane = create :lane, :with_cards, cards_count: 4
    card = lane.cards.ordered.second

    ChangePosition.new(card.lane).change! card, 2

    assert_equal 2, card.position
    assert_equal [0, 1, 2, 3], lane.cards.ordered.pluck(:position)
  end
end
