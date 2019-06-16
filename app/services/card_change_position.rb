# frozen_string_literal: true

class CardChangePosition
  def initialize(card)
    @card = card
  end

  def change_position(new_position, to_lane = nil)
    raise 'position must be more or eqeual to zero' if new_position < 0

    if to_lane.nil? || to_lane == lane
      ChangePosition.new(card, lane).change! new_position
    else
      move_across_lanes new_position, to_lane
    end
  end

  private

  attr_accessor :card

  delegate :position, :board, :lane, to: :card

  def move_across_lanes(new_position, to_lane)
    board.with_lock do
      from_lane = lane
      from_position = position
      to_lane.cards.where('position >= ?', new_position)
             .update_all 'position = position + 1' # rubocop:disable Rails/SkipsModelValidations
      card.update lane: to_lane, position: new_position
      from_lane.cards.where('position > ?', from_position)
               .update_all 'position = position - 1' # rubocop:disable Rails/SkipsModelValidations
    end
  end
end
