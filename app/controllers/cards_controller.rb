# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :require_login

  layout 'card'

  def edit
    render locals: { card: card }
  end
  def update
    card.task.update! permitted_params
    respond_to do |format|
      format.html { redirect_to board_path(card.board), notice: 'Задача изменена' }
      format.json { respond_with_bip card }
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def card
    @card ||= current_account.cards.find params[:id]
  end

  def permitted_params
    params.require(:card).permit(:title, :details)
  end
end
