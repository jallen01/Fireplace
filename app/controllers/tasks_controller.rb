class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, except: [:index, :new, :create]
  before_action :parse_form, only: [:create, :update]

  def index
    @new_task = Task.new(user: current_user)
    @tasks = current_user.get_tasks(session[:time_frame], session[:policies], session[:location])
  end


  def new
     @new_task = Task.new(user: current_user)
  end

  def create
    @new_task = current_user.add_task(params[:title], params[:content])
    
    unless @new_task.errors.any?
      @task = @new_task
      @new_task = Task.new(user: current_user)

      @task.update_metadata(@form_data)
    end

    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def edit
  end

  def update
    @task.update(task_params)
    @task.update_metadata(@form_data)
  end

  def destroy
    @task.destroy

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
  end

  # Stores filter time frame in session.
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_time_frame
    time_frame = params[:time_frame]
    session[:time_frame] = time_frame if Task::TIME_FRAMES.include?(time_frame)
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
    end

    # Sanitize params.
    def task_params
      params.require(:task).permit(:title, :content, :important, :long_lasting)
    end

    def parse_form
      @form_data = {}
      
      puts(params[:tags])

      @form_data[:tags] = ActiveSupport::JSON.decode(params[:tags]).map { |id| Tag.find_by(id: id) }.compact

      @form_data[:custom_time_range] = ActiveSupport::JSON.decode(params[:time_input_data])
      params[:custom_day_range] = ActiveSupport::JSON.decode(params[:day_input_data])

      @form_data[:time_ranges] = ActiveSupport::JSON.decode(params[:time_ranges]).map { |id| TimeRange.find_by(id: id) }.compact
      @form_data[:day_ranges] = ActiveSupport::JSON.decode(params[:day_ranges]).map { |id| DayRange.find_by(id: id) }.compact
    end
end
