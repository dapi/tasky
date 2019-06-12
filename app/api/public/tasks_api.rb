# frozen_string_literal: true

class Public::TasksAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Задачи в колонках'
  params do
    requires :lane_id, type: String
  end

  resources '/lanes/:lane_id' do
    helpers do
      def current_lane
        @current_lane = current_user.available_lanes.find params[:lane_id]
      end
    end

    resources :tasks do
      desc 'Список задач'
      get do
        present TaskSerializer.new current_lane.tasks.ordered, include: %i[lane]
      end

      desc 'Добавить задачу в колонку'
      params do
        requires :title, type: String
      end
      post do
        task = current_lane.tasks.create! title: params[:title], author: current_user

        present TaskSerializer.new task, include: %i[lane]
      end

      desc 'Удалить задачу'
      params do
        requires :id, type: String
      end
      namespace ':id' do
        delete do
          current_lane.tasks.find(params[:id]).destroy!

          :success
        end
      end
    end
  end
end
