# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :require_login

  def show
    edit
  end

  def edit
    render :edit,
           locals: { card: card },
           layout: request.xhr? ? false : 'card'
  end

  def update
    card.task.update! permitted_params
    respond_to do |format|
      format.html { redirect_to board_path(card.board), notice: flash_t }
      format.json { respond_with_bip card }
    end
  end

  def archive
    card.archive!
    # TODO: Notify lane only (board loose unseen comments count)
    BoardNotifyJob.perform_later card.board_id
    redirect_to board_path(card.board), notice: flash_t
  end

  private

  def card
    @card ||= current_account.cards.find params[:id]
  end

  def permitted_params
    params.require(:card).permit(:title, :details)
  end
end
