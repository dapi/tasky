# frozen_string_literal: true

# Make ActiveRecord model sortable in parent's scope
#

class Sortable < Module
  def self.new(parent_id: nil)
    Module.new do
      extend ActiveSupport::Concern

      included do
        scope :ordered, -> { order :position }

        before_create do
          max_position = self.class.where(parent_id => send(parent_id)).maximum(:position)
          self.position ||= max_position.nil? ? 0 : max_position + 1
        end
      end
    end
  end
end
