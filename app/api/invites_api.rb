# frozen_string_literal: true

class InvitesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def account
      @account ||= current_user.accounts.find params[:account_id]
    end
  end

  params do
    requires :account_id, type: String
  end

  resources :invites do
    params do
      requires :email, type: String
      optional :board_id, type: String
      optional :task_id, type: String
    end
    post do
      board = account.boards.find(params[:board_id]) if params[:board_id]
      task = account.tasks.find(params[:task_id]) if params[:task_id]

      result = Inviter
               .new(account: account,
                    inviter: current_user,
                    board: board,
                    task: task,
                    email: params[:email])
               .perform!

      present(result: result)
    end
  end
end
