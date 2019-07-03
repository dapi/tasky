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
    return if new_position == was_position

    parent.with_lock do
      if new_position < was_position # up
        move_up new_position
      elsif new_position > was_position # down
        move_down new_position
      end
      parent.touch
    end
  end

  private

  attr_reader :item, :parent

  delegate :position, to: :item

  def was_position
    return @was_position if instance_variable_defined? :@was_position

    @was_position = item.position
  end

  def move_up(new_position)
    scope.alive.where('position >= ?', new_position).update_all "position = position + #{SHIFT}"
    item.update_column :position, new_position
    scope.alive.where('position >= ?', SHIFT).update_all "position = position - #{SHIFT - 1}"
  end

  def move_down(new_position)
    scope.alive.where('position > ? and position <= ?', was_position, new_position).update_all "position = position + #{SHIFT}"
    item.update_column :position, new_position
    scope.alive.where('position >= ?', SHIFT).update_all "position = position - #{SHIFT + 1}"
  end

  def scope
    parent.send(item.class.model_name.plural)
  end
end
# rubocop:enable Rails/SkipsModelValidations
# rubocop:enable Metrics/AbcSize
