class WelcomeController < ApplicationController
  def index
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
          cards: [
            {id: 'Card1', title: 'Write Blog', description: 'Can AI make memes', label: '30 mins'},
            {id: 'Card2', title: 'Pay Rent', description: 'Transfer via NEFT', label: '5 mins', metadata: {sha: 'be312a1'}}
          ]
        }
      ]
    }
  end
end
