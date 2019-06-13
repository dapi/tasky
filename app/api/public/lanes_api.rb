# frozen_string_literal: true

class Public::LanesAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Колонки в досках'
  params do
    requires :board_id, type: String
  end

  resources '/boards/:board_id' do
    helpers do
      def current_board
        @current_board = current_user.available_boards.find params[:board_id]
      end
    end

    resources :lanes do
      desc 'Список досок'
      params do
        optional_metadata_query
        optional_include LaneSerializer
      end
      get do
        present by_metadata(LaneSerializer.new(current_board.lanes.ordered)), include: jsonapi_include
      end

      desc 'Добавить колонку в доску'
      params do
        requires :title, type: String
        optional :stage, type: Symbol,
                         values: LaneStages::STAGES,
                         default: LaneStages::DEFAULT_STAGE
        optional_metadata
      end
      post do
        lane = current_board.lanes.create! title: params[:title], stage: params[:stage], metadata: parsed_metadata

        present LaneSerializer.new lane
      end

      namespace ':lane_id' do
        desc 'Удалить колонку'
        delete do
          current_board.lanes.find(params[:lane_id]).destroy!
          :success
        end
      end
    end
  end
end
