# frozen_string_literal: true

class Lane < ApplicationRecord
  include Archivable
  include LaneStages
  include Sortable.new parent_id: :board_id
  nilify_blanks

  belongs_to :board
  has_many :cards, inverse_of: :lane, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :board_id }

  def reorder_tasks
    tasks.each_with_index do |task, index|
      task.update_column :position, index # rubocop:disable Rails/SkipsModelValidations
    end
  end
end
