# frozen_string_literal: true

class Board < ApplicationRecord
  include Archivable

  nilify_blanks

  belongs_to :account

  has_many :memberships, dependent: :delete_all, class_name: 'BoardMembership'
  has_many :members, through: :memberships, class_name: 'User'

  has_many :invites, class_name: 'BoardInvite', dependent: :delete_all

  has_many :lanes, dependent: :delete_all, inverse_of: :board
  has_many :cards, dependent: :delete_all
  has_many :tasks, through: :cards

  scope :ordered, -> { order :id }

  unless Rails.env.test?
    after_commit do
      notify
    end
  end

  def self.create_with_member!(attrs, member:)
    transaction do
      create!(attrs).tap do |board|
        board.members << member
        LaneStages::STAGES.each_with_index do |stage, index|
          board.lanes.create! title: stage, stage: stage, position: index
        end
      end
    end
  end

  private

  def notify
    return unless persisted?

    BoardChannel.broadcast_to(self, BoardPresenter.new(self).data)
  end
end
