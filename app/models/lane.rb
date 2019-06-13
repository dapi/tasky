# frozen_string_literal: true

class Lane < ApplicationRecord
  nilify_blanks

  include LaneStages
  include Sortable.new parent_id: :board_id

  belongs_to :board
  has_many :tasks, inverse_of: :lane, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :board_id }

  def reorder_tasks
    tasks.each_with_index do |task, index|
      task.update_column :position, index # rubocop:disable Rails/SkipsModelValidations
    end
  end
end
