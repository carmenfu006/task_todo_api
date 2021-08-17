class Api::V1::TasksController < ApplicationController
  before_action :find_task, only: [:show, :update, :destroy]

  # http://localhost:3000/api/v1/
  
  # GET /tasks 
  def index
    @tasks = Task.all
    render json: @tasks, status: :ok
  end

  # GET /tasks/1
  def show
    render json: @task, status: :ok
  end

  # POST /tasks
  def create
    @task = Task.create(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/1
  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/tasks/1
  def destroy
    @task.destroy
    # with status 204, request was successfully processed but is not returning any content
  end


  private
    def find_task
      @task = Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Task not found' }, status: :not_found
    end

    def task_params
      params.require(:task).permit(:title)
    end
end