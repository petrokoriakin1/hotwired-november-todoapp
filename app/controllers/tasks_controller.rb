# frozen_string_literal: true

class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to lists_url(@task.list), notice: I18n.t(:task_created) }
      else
        format.html { redirect_to lists_url(@task.list), alert: @task.errors.full_messages }
      end
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: params[:completed])

    render json: { message: 'Success' }
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to lists_url(@task.list), notice: I18n.t(:task_updated) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to lists_url(@task.list), notice: I18n.t(:task_deleted)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :section_id)
  end
end
