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

  def create
    board = current_account.boards.create_with_member!(
      permitted_params,
      member: current_user
    )

    flash.notice = 'Создана доска'
    redirect_to board_url(board, subdomain: current_account.subdomain)
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :new, locals: { board: e.record }, layout: 'simple'
  end

  def destroy
    board.destroy!
    redirect_to boards_path, notice: 'Доаска удалена'
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
          label: lane.stage,
          cards: lane.tasks.alive.ordered.map { |t| present_task t }
          # metadata: { taskId: 'Task1' },
          # tags: [ { title: 'High', color: 'white', bgcolor: '#EB5A46' },
        }
      end
    }
  end

  def present_task(task)
    { id: task.id, title: task.title, description: task.detail, label: I18n.l(task.created_at, format: :short) }
  end
end
