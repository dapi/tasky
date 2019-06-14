# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :require_login
  helper_method :current_board

  layout 'card'

  def edit
    render locals: { card: card }
  end

  # rubocop:disable Metrics/AbcSize
  def update
    respond_to do |format|
      if card.update permitted_params
        format.html { redirect_to board_path(card.board), notice: 'Задача изменена' }
      else
        format.html do
          flash.alert = e.message
          render :edit, locals: { card: card }
        end
      end
      format.json { respond_with_bip card }
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def current_board
    @current_board ||= current_user.available_boards.find params[:board_id]
  end

  def card
    @card ||= current_board.cards.find params[:id]
  end

  def permitted_params
    params.require(:card).permit(:title, :details)
  end
end
