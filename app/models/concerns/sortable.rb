# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
#
# Make ActiveRecord model sortable in parent's scope
#
class Sortable < Module
  MAX_POSITION = 10_000

  def self.new(parent_id: nil)
    Module.new do
      extend ActiveSupport::Concern

      included do
        scope :ordered, -> { order :position }

        before_create do
          max_position = self.class.where(parent_id => send(parent_id)).maximum(:position)
          self.position ||= max_position.nil? ? 0 : max_position + 1
        end

        before_update do
          raise "Position (#{position}} must be less then #{MAX_POSITION}" if position >= MAX_POSITION
        end
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
