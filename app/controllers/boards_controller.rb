# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :require_login

  def index
    render locals: { accounts: current_user.accounts }
  end

  def show
    render locals: { data: dashboard_data, board: board }
  end

  private

  def board
    @board ||= current_user.boards.find params[:id]
  end

  def dashboard_data
    {
      board: {
        id: board.id
      },
      lanes: board.lanes.map do |lane|
        {
          id: lane.id,
          title: lane.title,
          label: lane.stage,
          tasks: lane.tasks.map { |t| { id: t.id, title: t.title, description: t.detail, label: '30 mins' } }
          # metadata: { taskId: 'Task1' },
          # tags: [ { title: 'High', color: 'white', bgcolor: '#EB5A46' },
        }
      end
    }
  end
end
