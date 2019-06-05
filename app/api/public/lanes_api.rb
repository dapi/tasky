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
    requires :board_id, type: Integer
  end

  helpers do
    def current_board
      @current_board = current_user.available_boards.find params[:board_id]
    end
  end

  resources :lanes do
    desc 'Список досок'
    get do
      present LaneSerializer.new current_board.lanes.ordered, include: %i[board]
    end

    desc 'Добавить колонку в доску'
    params do
      requires :title, type: String
      optional :stage, type: String, desc: 'Стадия %{LanesStage::STAGES}. По-умолчанию %{LanesStage::DEFAULT_STAGE}'
    end
    post do
      lane = current_board.lanes.create! title: params[:title], stage: params[:stage]

      present LaneSerializer.new lane, include: %i[board]
    end
  end
end
