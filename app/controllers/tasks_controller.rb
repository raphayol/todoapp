# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[destroy]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task successfully created' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'Task successfully deleted' }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :title, :description, :due_date)
  end
end
