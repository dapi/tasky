# frozen_string_literal: true

class Lane < ApplicationRecord
  include Archivable
  include LaneStages
  include Sortable.new parent_id: :board_id
  nilify_blanks

  belongs_to :board, touch: true
  has_many :cards, inverse_of: :lane, dependent: :destroy
  has_many :ordered_alive_cards, -> { ordered.alive }, inverse_of: :lane, class_name: 'Card'
  has_one :account, through: :board

  scope :income, -> { todo }

  validates :title, presence: true, uniqueness: { scope: :board_id }

  def reorder_tasks
    tasks.each_with_index do |task, index|
      task.update_column :position, index # rubocop:disable Rails/SkipsModelValidations
    end
  end
end
