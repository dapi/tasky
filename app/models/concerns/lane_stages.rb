# frozen_string_literal: true

module LaneStages
  extend ActiveSupport::Concern

  DEFAULT_STAGE = :done
  STAGES = %i[todo doing done].freeze

  BADGE_CLASSES = {
    todo:  'badge-warning',
    doing: 'badge-primary',
    done:  'badge-success'
  }.freeze

  included do
    enum stage: STAGES

    before_create do
      self.stage ||= DEAFULT_STAGE
    end
  end

  def badge_class
    BADGE_CLASSES[stage.to_sym]
  end
end
