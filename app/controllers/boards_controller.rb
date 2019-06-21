# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :require_login

  def index
    redirect_to accounts_url
  end

  def show
    render locals: { data: dashboard_data, board: board }
  end

  def new
    render locals: { board: Board.new }, layout: 'simple'
  end

  def edit
    render locals: { board: board }, layout: 'simple'
  end

  # rubocop:disable Metrics/AbcSize
  def update
    board.update! permitted_params

    respond_to do |format|
      format.html { redirect_to board_url(board, subdomain: current_account.subdomain), notice: 'Обновление сохранено' }
      format.json { respond_with_bip board }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html do
        flash.alert = e.message
        render :edit, locals: { board: e.record }, layout: 'simple'
      end
      format.json { respond_with_bip board }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def create
    board = current_account.boards.create_with_member!(
      permitted_params,
      member: current_user
    )

    redirect_to board_url(board, subdomain: current_account.subdomain), notice: 'Создана доска'
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :new, locals: { board: e.record }, layout: 'simple'
  end

  def destroy
    board.destroy!
    redirect_to boards_path, notice: 'Доска удалена'
  end

  def archive
    board.archive!
    redirect_to boards_path, notice: 'Даска в архиве'
  end

  private

  def board
    @board ||= current_user.available_boards.find params[:id]
  end

  def permitted_params
    params.require(:board).permit(:title)
  end

  def dashboard_data
    {
      board: {
        id: board.id
      },
      lanes: board.lanes.alive.ordered.map do |lane|
        {
          id: lane.id,
          title: lane.title,
          # label: lane.stage,
          # labelStyle: { color: 'red' },
          cards: lane.cards.alive.ordered.map { |t| present_task t }
          # metadata: { taskId: 'Task1' },
          # tags: [ { title: 'High', color: 'white', bgcolor: '#EB5A46' },
        }
      end
    }
  end

  def present_task(card)
    {
      id: card.id,
      title: card.title,
      description: card.details,
      label: "position: #{card.position}",
      tags: parse_tags(card.title)
      # label: I18n.l(card.created_at, format: :short)
    }
  end

  def parse_tags(title)
    title.
      scan(/\[[^]]+\]/).
      map do |tag|
      title = tag.
        slice(0, tag.length-1).
        slice(-tag.length+2,tag.length-2)
      { title: title }
    end
  end
end
