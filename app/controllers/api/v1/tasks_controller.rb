class Api::V1::TasksController < ApplicationController
  def index
    tasks=Task.all
    if tasks.any?
      render json: tasks, status: :ok
    else
      render json: {
        error: 'Data not found'
      }, status: :not_found
    end 
  end

  def show
    task= Task.find_by(id: params[:id])
    if task
      render json: task, status: :ok
    else 
      render json: {
        error: 'Task not found'
      }, status: :not_found
    end 
  end

  def create
    task= Task.new(
      name: task_params[:name],
      description: task_params[:description],
      completed: task_params[:completed]
    )
    if task.save
      render json: task, status: :created
    else
      render json: {
        error: 'Error Creating the task'
      }, status: :unprocessable_entity
    end
  end

  def update
    task= Task.find_by(id: params[:id])
    if task
      if task.update(task_params)
        render json: 'Task Update successfully', status: :ok
      else
        render json: {
          error: 'Failed to update task'
        }, status: :unprocessable_entity
      end
    else 
      render json: {
        error: 'Task was not found'
      }, status: :not_found
    end
  end

  def destroy
    task= Task.find_by(id: params[:id])
    if task
      task.destroy
      render json: 'Task deleted successfully', status: :ok
    else
      render json: {
        error: 'Task was not found'
      }, status: :not_found
    end
  end
  # Create a private method to make the parameters private.
  private
  def task_params
    params.require(:task).permit(:name,:description,:completed)
  end
end
