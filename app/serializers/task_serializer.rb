# frozen_string_literal: true

class TaskSerializer
  include FastJsonapi::ObjectSerializer
  set_type :task

  belongs_to :lane
  belongs_to :author, record_type: :user, serializer: :User

  attributes :title, :position, :detail
end
