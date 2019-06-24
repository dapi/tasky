# frozen_string_literal: true

class Account::LanesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def current_board
      @current_board = current_account.boards.find params[:board_id]
    end
  end

  desc 'Колонки в досках'
  resources :lanes do
    desc 'Список досок'
    params do
      requires :board_id, type: String
      optional_metadata_query
      optional_include LaneSerializer
    end
    get do
      present by_metadata(LaneSerializer.new(current_board.lanes.ordered)), include: jsonapi_include
    end

    desc 'Добавить колонку в доску'
    params do
      requires :board_id, type: String
      requires :title, type: String
      optional :id, type: String
      optional :stage, type: Symbol,
                       values: LaneStages::STAGES,
                       default: LaneStages::DEFAULT_STAGE
      optional_metadata
    end
    post do
      lane = current_board.lanes.create!(
        id: params[:id], title: params[:title], stage: params[:stage], metadata: parsed_metadata
      )

      present LaneSerializer.new lane
    end

    resource ':id' do
      helpers do
        def current_lane
          @current_lane ||= current_account.lanes.find(params[:id])
        end
      end
      desc 'Удалить колонку'
      delete do
        current_lane.destroy!
        :success
      end
      desc 'Переместить колонку по другому индексу'
      params do
        requires :index, type: Integer, desc: 'Новая позиция (начиная с 0)'
      end
      put :move do
        ChangePosition.new(current_lane, current_lane.board).change! params[:index]
        present LaneSerializer.new current_lane
      end

      desc 'Изменить свойства колонки'
      params do
        optional :title, type: String
        optional :stage, type: Symbol,
                         values: LaneStages::STAGES,
                         default: LaneStages::DEFAULT_STAGE
        optional_metadata
      end

      put do
        current_lane.update! declared(params, include_missing: false)
        present LaneSerializer.new current_lane
      end
    end
  end
end
