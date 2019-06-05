# frozen_string_literal: true

class Board < ApplicationRecord
  nilify_blanks

  belongs_to :account

  has_many :memberships, dependent: :delete_all, class_name: 'BoardMembership'
  has_many :members, through: :memberships, class_name: 'User'

  validates :title, presence: true, uniqueness: { scope: :account_id }

  scope :ordered, -> { order :id }

  def self.create_with_member!(attrs, member: )
    transaction do
      create!(attrs).tap do |board|
        board.members << member
      end
    end
  end
end
