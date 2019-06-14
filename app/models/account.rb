# frozen_string_literal: true

class Account < ApplicationRecord
  include MetadataSupport
  include AccountSubdomain
  include Archivable

  nilify_blanks

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, inverse_of: :owned_accounts

  has_many :memberships, dependent: :delete_all, class_name: 'AccountMembership'
  has_many :members, through: :memberships, class_name: 'User'
  has_many :invites, dependent: :delete_all
  has_many :boards, dependent: :delete_all

  scope :ordered, -> { order :name }
  validates :name, presence: true

  after_create :attach_owner

  private

  def attach_owner
    members << owner
  end
end
