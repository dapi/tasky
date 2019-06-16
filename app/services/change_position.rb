# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations
#
class ChangePosition
  # Use this shift to respect unique index
  SHIFT = Sortable::MAX_POSITION

  def initialize(item, parent)
    @item = item
    @parent = parent
  end

  def change!(new_position)
    raise 'position must be more or eqeual to zero' if new_position < 0
    return if new_position == position

    parent.with_lock do
      if new_position < position # up
        move_up new_position
      elsif new_position > position # down
        move_down new_position
      end
    end
  end

  private

  attr_reader :item, :parent

  delegate :position, to: :item

  def move_up(new_position)
    scope.where('position >= ?', new_position).update_all "position = position + #{SHIFT}"
    item.update_column :position, new_position
    scope.where('position >= ?', SHIFT).update_all "position = position - #{SHIFT - 1}"
  end

  def move_down(new_position)
    scope.where('position >= ?', position).update_all "position = position + #{SHIFT}"
    item.update_column :position, new_position
    scope.where('position >= ?', SHIFT).update_all "position = position - #{SHIFT + 1}"
  end

  def scope
    parent.send(item.class.model_name.plural)
  end
end
# rubocop:enable Rails/SkipsModelValidations
