# frozen_string_literal: true

class BatchInviteJob < ApplicationJob
  include AutoLogger

  def perform(account_id:, board_id:, inviter_id:, emails:)
    @account = Account.find account_id
    @board = @account.boards.find board_id
    @inviter = User.find inviter_id

    emails.each do |email|
      make_invite email
    end
  end

  private

  attr_reader :account, :board, :inviter

  # rubocop:disable Metrics/AbcSize
  def make_invite(email)
    result = Inviter
             .new(account: account, board: board, inviter: inviter, email: email)
             .perform!
    logger.info "Made invite for '#{account.subdomain}', board_id=#{board.id}, inviter_id=#{inviter.id}, email=#{email}, result=#{result}"
  rescue StandardError => e
    logger.error "Error: Made invite for '#{account.subdomain}', board_id=#{board.id}, inviter_id=#{inviter.id}, email=#{email}, err=#{e}"
  end
  # rubocop:enable Metrics/AbcSize
end
