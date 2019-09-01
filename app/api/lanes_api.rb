# frozen_string_literal: true

class LanesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :lanes do
    params do
      requires :board_id, type: String
      optional_metadata_query
      optional_include LaneSerializer
    end
    get do
      board = current_user.available_boards.find params[:board_id]
      present by_metadata(LaneSerializer.new(board.lanes.ordered)), include: jsonapi_include
    end

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
      board = current_user.available_boards.find params[:board_id]
      lane = board.lanes.create!(
        id: params[:id], title: params[:title], stage: params[:stage], metadata: parsed_metadata
      )
      BoardChannel.update_lanes board
      present LaneSerializer.new lane
    end

    resource ':id' do
      helpers do
        def current_lane
          @current_lane ||= current_user.available_lanes.find(params[:id])
        end
      end
      delete do
        board = current_lane.board
        current_lane.destroy!
        BoardChannel.update_lanes board
        :success
      end
      desc 'Move lane'
      params do
        requires :index, type: Integer, desc: 'New lane position (starts from 0)'
      end
      put :move do
        board = current_lane.board
        ChangePosition.new(board).change! current_lane, params[:index]
        BoardChannel.update_lanes board
        present LaneSerializer.new current_lane
      end

      params do
        optional :title, type: String
        optional :stage, type: Symbol,
                         values: LaneStages::STAGES,
                         default: LaneStages::DEFAULT_STAGE
        optional_metadata
      end

      put do
        board = current_lane.board
        current_lane.update! declared(params, include_missing: false)
        BoardChannel.update_lanes board
        present LaneSerializer.new current_lane
      end
    end
  end
end
