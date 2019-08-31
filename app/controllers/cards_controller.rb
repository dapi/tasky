# frozen_string_literal: true

class CardsController < ApplicationController
  def show
    edit
  end

  def edit
    TaskSeen.new(card.task, current_user).mark_as_seen! Time.zone.now
    render :edit,
           locals: { card: card },
           layout: request.xhr? ? false : 'card'
  end

  def update
    card.task.update! permitted_params
    BoardChannel.update_lanes card.board
    redirect_to board_path(card.board), notice: flash_t
  end

  def archive
    card.archive!
    # TODO: Update card's modal
    BoardChannel.update_lanes card.board.reload
    redirect_to board_path(card.board), notice: flash_t
  end

  private

  def card
    @card ||= current_user.available_cards.find params[:id]
  end

  def permitted_params
    params.require(:card).permit(:title, :details)
  end
end
