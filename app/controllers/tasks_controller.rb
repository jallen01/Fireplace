class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_time_frame, only: [:index]
  before_action :set_task, except: [:index, :new, :create]
  before_action :set_user_context

  def index
    @new_task = Task.new(user: current_user)
  end

  def create
    @new_task = current_user.create_task(task_params[:title], task_params[:content])
    
    unless @new_task.errors.any?
      @task = @new_task
      @new_task = Task.new(user: current_user)

      @task.update_metadata(@metadata)
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @task.update(task_params)
    @task.update_metadata(@metadata)
  end

  def destroy
    @task_id = @task.id
    @task.destroy

    respond_to do |format|
      format.js
    end
  end
  
  private

    def set_task
      @task = Task.find_by(id: params[:id])

      # Check that task exists.
      unless @task
        respond_to do |format|
          format.js { render status: 404 }
        end
      end 

      # Check permissions.
      unless @task.user == current_user
        respond_to do |format|
          format.js { render status: 403 }
        end
      end
    end

    def reset_time_frame
      session[:time_frame] = :now
    end

    def set_user_context
      @user_context = current_user.get_context(session[:time_frame], session[:utc_offset], session[:location])
    end

    # Sanitize params.
    def task_params
      params.require(:task).permit(:title, :content, :important, :long_lasting, :deadline, :days_notice)
    end
end
