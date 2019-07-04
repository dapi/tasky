# frozen_string_literal: true

class User < ApplicationRecord
  include Gravatarify::Helper
  authenticates_with_sorcery!
  nilify_blanks

  attr_accessor :with_account

  has_many :owned_accounts, class_name: 'Account', inverse_of: :owner, foreign_key: :owner_id, dependent: :destroy
  has_many :account_memberships, inverse_of: :member, foreign_key: :member_id, dependent: :delete_all
  has_many :accounts, through: :account_memberships
  has_one :personal_account, -> { where is_personal: true }, class_name: 'Account', inverse_of: :owner, foreign_key: :owner_id

  has_many :board_memberships, inverse_of: :member, foreign_key: :member_id, dependent: :destroy
  has_many :boards, -> { ordered }, through: :board_memberships

  has_many :available_boards, through: :accounts, source: :boards

  has_many :authored_tasks, class_name: 'Task', foreign_key: :author_id, dependent: :restrict_with_error, inverse_of: :author

  has_many :available_lanes, through: :available_boards, source: :lanes
  has_many :available_tasks, through: :accounts, source: :tasks
  has_many :available_cards, through: :accounts, source: :cards

  validates :name, presence: true
  validates :nickname, uniqueness: true, if: :nickname?
  validates :email, email: true, presence: true, uniqueness: true

  after_create :create_personal_account!, if: :with_account

  before_create :generate_access_key

  def public_name
    name.presence || email
  end

  def public_nickname
    '@' + (nickname.presence || name.presence || email.split('@').first)
  end

  def mail_address
    a = Mail::Address.new
    a.address = email
    a.display_name = name if name.present?
    a.format
  end

  def avatar_url(size: 24)
    gravatar_attrs(email, size: size)[:src]
  end

  def web_notify(message)
    ActionCable.server.broadcast "web_notifications_#{id}", message: message
  end

  def create_personal_account!
    account = owned_accounts.create! name: public_name, is_personal: true
    account.boards.create_with_member!({ title: public_name }, member: self)
  end

  private

  def generate_access_key
    self.access_key = SecureRandom.hex(20)
  end
end
