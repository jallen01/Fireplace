class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, except: [:index, :new, :create]

  def index
    @new_task = Task.new(user: current_user)
    filter_tasks
  end

  def create
    @new_task = current_user.create_task(task_params[:title], task_params[:content])
    
    unless @new_task.errors.any?
      @task = @new_task
      @new_task = Task.new(user: current_user)

      @task.update_metadata(@metadata)
    end

    filter_tasks

    respond_to do |format|
      format.js
    end
  end

  def update
    @task.update(task_params)
    @task.update_metadata(@metadata)

    filter_tasks
  end

  def destroy
    @task.destroy

    filter_tasks

    respond_to do |format|
      format.js
    end
  end

  # Stores filter policies in session.
  # 'policies' must be a hash. Ignores keys not in 'POLICIES'.
  def update_policies
    params[:policies].each do |k, v| 
      # Ensure that value is boolean with !!
      session[k] = !!v if Task::POLICIES.include?(k)
    end

    filter_tasks

    respond_to do |format|
      format.js
    end
  end

  # Stores filter time frame in session.
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_time_frame
    time_frame = params[:time_frame]
    session[:time_frame] = time_frame if Task::TIME_FRAMES.include?(time_frame)

    filter_tasks

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

    def filter_tasks
      @tasks = current_user.get_tasks(session[:time_frame], session[:policies], session[:location])
    end

    # Sanitize params.
    def task_params
      params.require(:task).permit(:title, :content, :important, :long_lasting, :deadline, :days_notice)
    end
end
