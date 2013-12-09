class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_context_overrides, only: [:index]
  before_action :set_task, except: [:index, :new, :create]
  before_action :set_context

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

    flash[:list] = "Task Created"

    respond_to do |format|
      format.js
    end
  end

  def update
    @task.update(task_params)
    @task.update_metadata(@metadata)

    flash[:list] = "Task Updated"

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @task_id = @task.id
    @task.destroy

    flash[:list] = "Task Deleted"

    respond_to do |format|
      format.js
    end
  end
  
  private

    def set_task
      @task = current_user.get_tasks.find_by(id: params[:id])

      # Check that task exists.
      unless @task
        respond_to do |format|
          format.js { render status: 404 }
        end
      end
    end

    def reset_context_overrides
      session[:context_overrides] = { time_frame: :now, location: nil }
    end

    def set_context
      @context = current_user_context
    end

    # Sanitize params.
    def task_params
      params.require(:task).permit(:title, :content, :important, :quick)
    end
end
