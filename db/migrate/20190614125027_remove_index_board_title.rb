# frozen_string_literal: true

class RemoveIndexBoardTitle < ActiveRecord::Migration[5.2]
  def change
    remove_index :boards, %i[account_id title]
  end
end
