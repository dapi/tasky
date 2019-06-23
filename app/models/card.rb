# frozen_string_literal: true

class Card < ApplicationRecord
  include Sortable.new parent_id: :lane_id
  include Archivable

  belongs_to :board
  belongs_to :lane
  belongs_to :task
  has_one :author, through: :task

  has_one :account, through: :board
  has_many :comments, through: :task

  before_validation do
    self.board_id ||= lane.try(:board_id)
  end

  delegate :title, :details, :formatted_details, :comments_count, to: :task
end
