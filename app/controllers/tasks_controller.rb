# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_login

  layout 'task'

  def edit
    render locals: { task: task }
  end

  # rubocop:disable Metrics/AbcSize
  def update
    respond_to do |format|
      if task.update permitted_params
        format.html { redirect_to board_path(task.board), notice: 'Задача изменена' }
      else
        format.html do
          flash.alert = e.message
          render :edit, locals: { task: task }
        end
      end
      format.json { respond_with_bip task }
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def task
    @task ||= current_account.tasks.find params[:id]
  end

  def permitted_params
    params.require(:task).permit(:title, :details)
  end
end
