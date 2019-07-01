# frozen_string_literal: true

class Account::CardsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :cards do
    params do
      optional :lane_id, type: String
      optional :board_id, type: String
      mutually_exclusive :board_id, :lane_id
      optional_include CardSerializer
    end
    get do
      if params[:lane_id].present?
        lane = current_account.lanes.find params[:lane_id]
        cards = lane.cards
      elsif params[:board_id].present?
        board = current_account.boards.find params[:board_id]
        cards = board.cards
      else
        raise 'WTF'
      end
      present CardSerializer.new by_metadata(cards.ordered), include: jsonapi_include
    end

    params do
      requires :title, type: String
      optional :board_id, type: String
      optional :lane_id, type: String
      at_least_one_of :board_id, :lane_id
      optional :task_id, type: String, desc: 'Creates new task if empty'
      optional :details, type: String
      optional :id, type: String
      optional_include CardSerializer
    end
    post do
      board = current_account.boards.find params[:board_id] if params[:board_id].present?
      if params[:lane_id].present?
        lane = board.present? ? board.lanes.find(params[:lane_id]) : current_account.lanes.find(params[:lane_id])
      else
        raise 'board_id is required' if board.blank?

        lane = board.income_lane
      end
      card = current_account.with_lock do
        task = if params[:task_id]
                 current_account.tasks.find(params[:task_id])
               else
                 current_account.tasks.create!(
                   title: params[:title] || 'No title',
                   details: params[:details],
                   author: current_user,
                   metadata: parsed_metadata
                 )
               end
        lane.cards.create! id: params[:id], board: board, lane: lane, task: task
      end

      present CardSerializer.new by_metadata(card), include: jsonapi_include
    end

    params do
      requires :id, type: String
    end
    namespace ':id' do
      helpers do
        def current_card
          @current_card ||= current_account.cards.find(params[:id])
        end
      end
      params do
        optional :title, type: String
        optional :details, type: String
      end
      put do
        current_card.task.update! declared(params, include_missing: false).slice('details', 'title')
        present CardSerializer.new current_card, include: jsonapi_include
      end

      delete do
        current_card.destroy!

        :success
      end

      desc 'Move to other lane'
      params do
        requires :to_lane_id, type: String, desc: 'В какую колонку переместить'
        requires :index, type: Integer, desc: 'Новая позиция (начиная с 0)'
      end
      put :move_across do
        to_lane = current_account.lanes.find params[:to_lane_id]
        if to_lane.nil? || to_lane == current_card.lane
          ChangePosition.new(current_card, current_card.lane).change! params[:index]
        else
          CardChangePosition.new(current_card).change_position params[:index], to_lane
        end
        present CardSerializer.new current_card
      end
    end
  end
end
