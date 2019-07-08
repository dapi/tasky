class AddLastCommentToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :last_comment, type: :uuid, foreign_key: {to_table: :task_comments}
    add_column :tasks, :last_comment_at, :timestamp

    Task.find_each do |task|
      task.comments.ordered.last.send :touch_task if task.comments.any?
    end
  end
end
