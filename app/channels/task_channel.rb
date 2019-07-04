# frozen_string_literal: true

class TaskChannel < ApplicationCable::Channel
  NAME = 'task'

  def subscribed
    task = Task.find params[:id]
    stream_for task
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
