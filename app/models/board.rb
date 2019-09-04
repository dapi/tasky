# frozen_string_literal: true

class Board < ApplicationRecord
  include PgSearch::Model
  include Archivable
  include MetadataSupport

  nilify_blanks

  belongs_to :account

  has_many :memberships, dependent: :delete_all, class_name: 'BoardMembership'
  has_many :members, through: :memberships, class_name: 'User'

  has_many :invites, class_name: 'Invite', dependent: :delete_all

  has_many :lanes, dependent: :delete_all, inverse_of: :board
  has_many :ordered_alive_lanes, -> { ordered.alive }, class_name: 'Lane', inverse_of: :board
  has_many :cards, dependent: :delete_all
  has_many :tasks, through: :cards
  has_many :task_users, through: :tasks

  scope :ordered, -> { order :id }

  multisearchable against: :title

  validates :title, presence: true

  def public_name
    title
  end

  def income_lane
    lanes.income.first
  end

  def income_lane!
    income_lane || raise("No income lane defined for board #{id}")
  end
end
