class Api::V1::TaskListsController < ApplicationController
  before_action :find_task, only: [:index, :create]
  before_action :find_task_list, only: [:show, :update, :destroy]

  # GET /tasks/1/task_lists
  def index
    @task_lists = @task.task_lists
    render json: @task_lists, status: :ok
  end

  # GET /tasks/1/task_lists/1
  def show
    render json: @task_list, status: :ok
  end

  # POST /tasks/1/task_lists
  def create
    @task_list = @task.task_lists.create(task_list_params)

    if @task_list.save
      render json: @task_list, status: :created
    else
      render json: { errors: @task_list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/1/task_lists/1
  def update
    if @task_list.update(task_list_params)
      render json: @task_list, status: :ok
    else
      render json: { errors: @task_list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1/task_lists/1
  def destroy
    @task_list.destroy
  end

  private
    def find_task
      @task = Task.find(params[:task_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Task not found' }, status: :not_found
    end

    def find_task_list
      @task_list = TaskList.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Task list not found' }, status: :not_found
    end

    def task_list_params
      params.require(:task_list).permit(:to_do, :completed)
    end
end