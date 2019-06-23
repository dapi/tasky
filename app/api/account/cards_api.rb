# frozen_string_literal: true

class Account::CardsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def current_lane
      @current_lane ||= current_account.lanes.find params[:lane_id]
    end

    def current_board
      @current_board ||= current_lane.board
    end
  end

  desc 'Карточки в колонках'
  resources :cards do
    desc 'Список карточек'
    params do
      requires :lane_id, type: String
      optional_include CardSerializer
    end
    get do
      present CardSerializer.new by_metadata(current_board.cards.ordered), include: jsonapi_include
    end

    desc 'Создать карточку в колонке'
    params do
      optional :task_id, type: String,
                         desc: 'ID задачи к которой привязывается эта карточки. Если не указано, создается новая задача'
      optional :details, type: String
      requires :title, type: String
      optional :id, type: String, desc: 'ID карточки, если он уже есть'
      optional_include CardSerializer
    end
    post do
      card = current_account.with_lock do
        task = if params[:task_id]
                 current_account.tasks.find(params[:task_id])
               else
                 current_account.tasks.create!(
                   title: params[:title] || 'Без названия',
                   details: params[:details],
                   author: current_user,
                   metadata: parsed_metadata
                 )
               end
        current_lane.cards.create!(
          id: params[:id],
          board: current_board,
          lane_id: current_lane,
          task: task
        )
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
      desc 'Изменить данные карточки'
      params do
        optional :title, type: String
        optional :details, type: String
      end
      put do
        current_card.task.update! declared(params, include_missing: false).slice('details', 'title')
        present CardSerializer.new current_card, include: jsonapi_include
      end

      desc 'Удалить карточку из колонки'
      delete do
        current_card.destroy!

        :success
      end

      desc 'Переместить в другую колонку'
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
