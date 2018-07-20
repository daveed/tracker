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

    private
    def index_params
      params.permit(:page, :page_size).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit(:name, :description, :project_id)
    end
  end
end
