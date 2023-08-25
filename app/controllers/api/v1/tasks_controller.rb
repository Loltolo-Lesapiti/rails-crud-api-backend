class Api::V1::TasksController < ApplicationController
  def index
  end

  def show
  end

  def create
    task= Task.new([
      name: task_params[:name],
      description: task_params[:description],
      completed: task_params[:completed]
    ])
    if task
      render json: task, status: :created
    else
      render json: {
        error: 'Error Creating the task'
      }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end
  # Create a private method to make the parameters private.
  private
  def task_params
    params.require(:task).permit([
      name,
      description,
      completed
    ])
  end
end