# frozen_string_literal: true

class InvitesController < ApplicationController
  skip_before_action :require_login

  # rubocop:disable Metrics/AbcSize
  def accept
    raise HumanizedError, 'Выйдите из системы чтобы воспользоваться ссылкой-приглашением' if logged_in?

    invite = Invite.find_by! token: params[:id]

    auto_login InviteAcceptor.new(invite).accept!

    flash_notice! :invite_accepted

    if invite.board.present?
      redirect_to board_url(invite.board, subdomain: invite.account.subdomain)
    else
      redirect_to account_url(subdomain: invite.account.subdomain)
    end
  rescue ActiveRecord::RecordNotFound
    raise HumanizedError, 'Данная ссылка уже устарела. Попросите новый инвайт'
  end
  # rubocop:enable Metrics/AbcSize
end
