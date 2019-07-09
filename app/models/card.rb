# frozen_string_literal: true

class Card < ApplicationRecord
  include Sortable.new parent_id: :lane_id
  include Archivable

  belongs_to :board, touch: true
  belongs_to :lane, touch: true
  belongs_to :task

  has_one :account, through: :board
  has_one :author, through: :task

  has_many :comments, through: :task
  has_many :memberships, class_name: 'CardMembership', dependent: :delete_all
  has_many :account_memberships, through: :memberships
  has_many :members, through: :account_memberships
  has_many :task_users, through: :task

  scope :open, -> { alive }

  before_validation do
    self.board_id ||= lane.try(:board_id)
  end

  delegate :title, :details, :formatted_details, :comments_count, :attachments_count, to: :task
end
