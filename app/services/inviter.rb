# frozen_string_literal: true

# Service account invitings.
#
# Find user by email and create membership for him.
# If user is not exists, create invite record and send him email
class Inviter
  def initialize(account:, email:, inviter:, task: nil, board: nil)
    @account = account
    @email   = email
    @inviter = inviter
    @task    = task
    @board   = board || task.try(:board)
  end

  def perform!
    if user.present?
      add_membership
      # TODO: Notify user
      :membership_created
    else
      invite = create_invite
      UserMailer
        .invite(invite.id)
        .deliver_later

      :invited
    end
  end

  private

  attr_reader :account, :task, :board, :email, :inviter

  def user
    @user ||= User.find_by(email: email.to_s.downcase)
  end

  def create_invite
    account.invites
           .create_with!(inviter: inviter)
           .find_or_create_by!(board: board, task: task, email: email)
  end

  # rubocop:disable Metrics/AbcSize
  def add_membership
    account.with_lock do
      account.members << user unless account.members.include? user
      board.members << user if board.present? && !board.members.include?(user)

      if task.present?
        task.cards.find_each do |card|
          card.members << user unless card.members.include? user
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
