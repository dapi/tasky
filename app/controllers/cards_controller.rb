# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :require_login

  def show
    edit
  end

  def edit
    TaskSeen.new(card.task, current_user).mark_as_seen! Time.zone.now
    # TODO: Notify to update card on the front
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
    # TODO: Update card's Lane
    # TODO Update card's modal
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
