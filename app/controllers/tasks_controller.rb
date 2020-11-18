# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!

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

  private

  def task_params
    params.require(:task).permit(:id, :title, :description, :due_date)
  end
end
