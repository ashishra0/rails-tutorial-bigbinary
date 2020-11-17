class TasksController < ApplicationController
  before_action :load_task, only: [:show, :edit]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render status: :ok, json: { notice: 'Task was successfully created', id: @task.id }
    else
      errors = @task.errors.full_messages
      render status: :unprocessable_entity, json: { errors: errors  }
    end
  end

  def show
    render
  end

  def edit
    render
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def load_task
    @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound => errors
      render json: {errors: errors}
  end
end
