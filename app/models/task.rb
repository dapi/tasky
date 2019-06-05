# frozen_string_literal: true

class Task < ApplicationRecord
  include Sortable.new parent_id: :lane_id

  belongs_to :lane
  belongs_to :author, class_name: 'User'
end
