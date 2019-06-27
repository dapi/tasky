# frozen_string_literal: true

class Account::InvitesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :invites do
    params do
      requires :email, type: String
      optional :board_id, type: String
      optional :task_id, type: String
    end
    post do
      board = current_account.boards.find(params[:board_id]) if params[:board_id]
      task = current_account.tasks.find(params[:task_id]) if params[:task_id]

      result = Inviter
               .new(account: current_account,
                    inviter: current_user,
                    board: board,
                    task: task,
                    email: params[:email])
               .perform!

      present(result: result)
    end
  end
end
