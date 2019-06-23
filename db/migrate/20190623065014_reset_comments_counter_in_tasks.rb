# frozen_string_literal: true

class ResetCommentsCounterInTasks < ActiveRecord::Migration[5.2]
  def change
    Task.pluck(:id).each do |id|
      Task.reset_counters id, :comments
    end
  end
end
