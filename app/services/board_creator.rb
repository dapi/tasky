# frozen_string_literal: true

#
# Creates board with default lanes and add owner as first member
#
class BoardCreator
  DEFAULT_STAGES = LaneStages::STAGES

  def initialize(account)
    @account = account
  end

  def perform(attrs:, owner:)
    @account.with_lock do
      @account.boards.create!(attrs).tap do |board|
        board.members << owner if owner.present?
        DEFAULT_STAGES.each_with_index do |stage, index|
          board.lanes.create! title: stage, stage: stage, position: index
        end
      end
    end
  end
end
