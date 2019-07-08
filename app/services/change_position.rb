# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations
# rubocop:disable Metrics/AbcSize
class ChangePosition
  include AutoLogger

  # Use this shift to respect unique index
  SHIFT = Sortable::MAX_POSITION

  def initialize(parent)
    @parent = parent
  end

  def change!(item, new_position)
    @item = item
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

  def checkup!(items_scope_name)
    @items_scope_name = items_scope_name
    has_errors = false
    index = 0
    parent.with_lock do
      scope.ordered.each do |item|
        unless item.position == index
          logger.warn "Position of #{parent.class}##{parent.id}->#{item.class}##{item.id} is wrong #{item.position} change it to #{index}"
          has_errors = true
          item.update_column :position, index
        end

        index += 1
      end
      parent.touch
    end
    Bugsnag.notify "#{parent.class}##{parent.id} has wrong positions of #{items_scope_name} look into log (#{_auto_logger_file}) for more info" if has_errors
  end

  private

  attr_reader :item, :parent

  delegate :position, to: :item

  def was_position
    return @was_position if instance_variable_defined? :@was_position

    @was_position = item.position
  end

  def move_up(new_position)
    scope.where('position >= ?', new_position).update_all "position = position + #{SHIFT}"
    item.update_column :position, new_position
    scope.where('position >= ?', SHIFT).update_all "position = position - #{SHIFT - 1}"
  end

  def move_down(new_position)
    scope.where('position > ? and position <= ?', was_position, new_position).update_all "position = position + #{SHIFT}"
    item.update_column :position, new_position
    scope.where('position >= ?', SHIFT).update_all "position = position - #{SHIFT + 1}"
  end

  def scope
    parent.send(@items_scope_name || item.class.model_name.plural).alive
  end
end
# rubocop:enable Rails/SkipsModelValidations
# rubocop:enable Metrics/AbcSize
