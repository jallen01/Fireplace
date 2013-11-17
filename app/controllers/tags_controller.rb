class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, except: [:index, :new, :create]

  def index
    @new_tag = Tag.new(user: current_user)
    @tags = current_user.tags
  end

  def new
  end

  def create
    @new_tag = current_user.add_tag(params[:name])
    unless @new_tag.errors.any?
      @new_tag = Tag.new(user: current_user)
      @new_tag.update_metadata(params[:metadata])

      # metadata[:day_range] = [false, true, true, false, false,...]
      # metadata[:time_range] = [false, true, true, ...]
      # metadata[:locations] = [id1, id2, ...]
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
    @task.update_metadata(params[:metadata])

    # metadata[:day_range] = [false, true, true, false, false,...]
    # metadata[:time_range] = [false, true, true, ...]
    # metadata[:locations] = [id1, id2, ...]
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
end
