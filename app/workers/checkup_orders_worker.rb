# frozen_string_literal: true

# Checks cards and lanes position order
#
# This is temporary worker
#
class CheckupOrdersWorker
  include Sidekiq::Worker

  def perform
    Board.find_each { |board| ChangePosition.new(board).checkup! :lanes }
    Lane.find_each { |lane| ChangePosition.new(lane).checkup! :cards }
  end
end
