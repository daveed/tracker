module V1
  class TasksController < ApplicationController

    swagger_api :index do
      summary 'List all tasks'
      notes 'This lists all the tasks per project'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 25'
    end
    def index
      tasks, errors = ListTasks.new(index_params).call
      if errors.any?
        render json: { errors: errors }, status: 400
      else
        render json: tasks
      end
    end

    swagger_api :show do
      summary 'Fetch a single Task'
      param :path, :id, :string, :required, 'Task Id'
      param :path, :project_id, :string, :required, 'Project Id'
    end

    def show
      task, error = GetTask.new(assoc_params).call
      if task.present?
        render json: task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task'
      param :form, :name, :string, :required, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
    end
    def create
      task = Task.create task_params
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    swagger_api :update do
      summary 'Updates an existing Task'
      param :path, :id, :string, :required, 'Task Id'
      param :path, :project_id, :string, :required, 'Project Id'
      param :form, :name, :string, :optional, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
    end
    def update
      task = Task.find_by id: params[:id]
      if task.present? && task.transition(event_params) && task.update_attributes(task_params)
        render json: task, status: 200
      elsif task.present?
        render json: { errors: task.errors.full_messages }, status: 400
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    private

    def index_params
      params.permit(:page, :page_size).to_h.symbolize_keys
    end

    def assoc_params
      params.permit(:id, :project_id).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit(:id, :name, :description, :state, :project_id)
    end

    def event_params
      params.require(:task).permit(:event).to_h.symbolize_keys[:event]
    end
  end
end
