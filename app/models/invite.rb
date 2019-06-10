# frozen_string_literal: true

class Invite < ApplicationRecord
  belongs_to :account
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User', optional: true

  has_many :board_invites, dependent: :delete_all

  validates :email, presence: true, email: true, uniqueness: { scope: :account_id }
  validate :validate_members_existence, if: :find_invitee

  before_create :create_member, if: :find_invitee

  private

  def find_invitee
    return @find_invitee if defined? @find_invitee

    @find_invitee = User.find_by(email: email)
  end

  def validate_members_existence
    return unless account.members.include? find_invitee

    errors.add :email, "Пользователь с емайлом #{email} уже присутсвует в указаном аккаунте"
  end

  def create_member
    account.members << (self.invitee = find_invitee)
  end
end
