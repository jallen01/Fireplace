class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, except: [:index, :new, :create]
  before_action :set_context

  def index
    @new_task = Task.new(user: current_user)
  end

  def create
    @new_task = current_user.create_task(task_params[:title], task_params[:content])
    @new_task.update(task_params)
    
    unless @new_task.errors.any?
      @task = @new_task
      @new_task = Task.new(user: current_user)

      @task.update_metadata(@metadata)
      flash.now[:list] = "Task Created"
    end
  end

  def update
    @task.update(task_params)
    @task.update_metadata(@metadata)

    unless @task.errors.any?
      flash.now[:list] = "Task Updated"
    end
  end

  def destroy
    @task_id = @task.id
    @task.destroy

    flash.now[:list] = "Task Deleted"
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

    def set_context
      @context = current_user_context
    end

    # Sanitize params.
    def task_params
      params.require(:task).permit(:title, :content, :important, :quick)
    end
end
