class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, except: [:index, :new, :create]
  before_action :parse_form, only: [:create, :update]

  def index
    @new_tag = Tag.new(user: current_user)
    @tags = current_user.tags
  end

  def new
    @new_tag = Tag.new(user: current_user)
  end

  def create
    @new_tag = current_user.add_tag(params[:name])

    unless @new_tag.errors.any?
      @new_tag = Tag.new(user: current_user)
      @new_tag.update_metadata(@form_data)
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
  end

  private

    def set_tag
      @tag = Tag.find_by(id: params[:id])

      # Check that tag exists.
      unless @tag
        respond_to do |format|
          flash.alert = "Tag not found."
          format.js { render js: "window.location.href = '#{home_url}" }
        end
      end 

      # Check that current user owns tag.
      unless @tag.user == current_user
        respond_to do |format|
          flash.alert = "Forbidden to access tag."
          format.js { render js: "window.location.href = '#{home_url}'" }
        end
      end
    end

    # Sanitize params.
    def tag_params
      params.require(:tag).permit(:name)
    end

    def parse_form
      @form_data = {}

      @form_data[:custom_time_range] = ActiveSupport::JSON.decode(params[:time_input_data])
      params[:custom_day_range] = ActiveSupport::JSON.decode(params[:day_input_data])

      @form_data[:time_ranges] = ActiveSupport::JSON.decode(params[:time_ranges]).map { |id| TimeRange.find_by(id: id) }.compact
      @form_data[:day_ranges] = ActiveSupport::JSON.decode(params[:day_ranges]).map { |id| DayRange.find_by(id: id) }.compact
    end
end
