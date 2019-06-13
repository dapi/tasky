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
        @current_lane ||= current_user.available_lanes.find params[:lane_id]
      end
    end

    resources :tasks do
      desc 'Список задач'
      params do
        optional_metadata_query
        optional_include TaskSerializer
      end
      get do
        present TaskSerializer.new by_metadata(current_lane.tasks.ordered), include: jsonapi_include
      end

      desc 'Добавить задачу в колонку'
      params do
        requires :title, type: String
        optional_metadata
      end
      post do
        task = current_lane.tasks.create! title: params[:title], author: current_user, metadata: parsed_metadata

        present TaskSerializer.new task
      end

      params do
        requires :task_id, type: String
      end
      namespace ':task_id' do
        helpers do
          def current_task
            @current_task ||= current_lane.tasks.find(params[:task_id])
          end
        end
        desc 'Удалить задачу'
        delete do
          current_task.destroy!

          :success
        end

        desc 'Переместить в другую колонку'
        params do
          requires :to_lane_id, type: String, desc: 'В какую колонку переместить'
          requires :index, type: Integer, desc: 'Новая позиция (начиная с 0)'
        end
        put :move_across do
          to_lane = current_user.available_lanes.find params[:to_lane_id]
          current_task.change_position params[:index], to_lane
          present TaskSerializer.new current_task
        end
      end
    end
  end
end
