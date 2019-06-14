# frozen_string_literal: true

class RenameDetailToDetailsInTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :detail, :details
  end
end
