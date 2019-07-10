# frozen_string_literal: true

class TaskUserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :task_user

  attributes :unseen_comments_count
end
