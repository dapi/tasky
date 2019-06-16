# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations
# rubocop:disable Metrics/AbcSize
#
class ChangePosition
  def initialize(item, parent)
    @item = item
    @parent = parent
  end

  def change!(new_position)
    return if new_position == position

    parent.with_lock do
      if new_position < position # up
        scope.where('position >= ?', new_position).update_all 'position = position + 1'
        item.update_column :position, new_position
      elsif new_position > position # down
        scope.where('position >= ?', position).update_all 'position = position - 1'
        item.update_column :position, new_position
      end
    end
  end

  private

  attr_reader :item, :parent

  delegate :position, to: :item

  def scope
    parent.send(item.class.model_name.plural)
  end
end
# rubocop:enable Rails/SkipsModelValidations
# rubocop:enable Metrics/AbcSize
