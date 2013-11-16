class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, except: [:index, :new, :create]
  before_action :check_permissions, except: [:index, :new, :create]

  def index
  end

  def new

  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def set_task
      @task = Task.find_by(id: params[:id])

      # Check that task exists.
      unless @task
        respond_to do |format|
          flash.alert = "Task not found."
          format.js { render js: "window.location.href = '#{home_url}" }
        end
      end 

      # Check that current user owns task.
      unless @task.user == current_user
        respond_to do |format|
          flash.alert = "Forbidden to access task."
          format.js { render js: "window.location.href = '#{home_url}'" }
        end
      end
    end

    # Sanitize params.
    def task_params
      params.require(:task).permit(:title, :content, :important, :long_lasting)
    end
end
