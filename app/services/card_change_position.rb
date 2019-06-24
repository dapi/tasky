# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations, Metrics/AbcSize
#
# TODO: Rename to MoveCardAcrossLanes
class CardChangePosition
  # Use this shift to respect unique index
  SHIFT = Sortable::MAX_POSITION

  def initialize(card)
    @card = card
  end

  def change_position(new_position, to_lane)
    raise 'position must be more or eqeual to zero' if new_position < 0

    board = card.board
    board.with_lock do
      from_lane = card.lane
      from_position = card.position

      to_lane.cards.where('position >= ?', new_position)
             .update_all "position = position + #{SHIFT}"

      card.update lane: to_lane, position: new_position

      to_lane.cards.where('position >= ?', SHIFT)
             .update_all "position = position - #{SHIFT - 1}"

      from_lane.cards.where('position > ?', from_position)
               .update_all 'position = position - 1'

      board.touch
    end
  end

  private

  attr_accessor :card
end
# rubocop:enable Rails/SkipsModelValidations, Metrics/AbcSize
