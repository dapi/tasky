# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :require_login

  def index
    render locals: { accounts: current_user.accounts }
  end

  def show
    render locals: { data: dashboard_data }
  end

  private

  def dashboard_data
    {
      lanes: [
        {
          id: 'lane',
          title: 'Plannet tasks',
          label: '2/2',
          tasks: [
            { id: 'Task1', title: 'Write Blog', description: 'Can AI make memes', label: '30 mins',

              metadata: { taskId: 'Task1' },
              tags: [
                { title: 'High', color: 'white', bgcolor: '#EB5A46' },
                { title: 'Tech Debt', color: 'white', bgcolor: '#0079BF' },
                { title: 'Very long tag that is', color: 'white', bgcolor: '#61BD4F' },
                { title: 'One more', color: 'white', bgcolor: '#61BD4F' }
              ] },
            { id: 'Task2', title: 'Pay Rent', description: 'Transfer via NEFT', label: '5 mins', metadata: { sha: 'be312a1' } }
          ]
        }
      ]
    }
  end
end
