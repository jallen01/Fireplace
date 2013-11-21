class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, except: [:index, :new, :create]

  def create
    @new_tag = current_user.create_tag(params[:name])

    unless @new_tag.errors.any?
      @tag = @new_tag
      @new_tag = Tag.new(user: current_user)
      @tags = current_user.get_tags

      @new_tag.update_metadata(@metadata)
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @tag.update(task_params)
    @tag.update_metadata(@metadata)

    @tags = current_user.get_tags
  end

  def destroy
    @tag.destroy
    @tags = current_user.get_tags

    respond_to do |format|
      format.js
    end
  end

  private

    def set_tag
      @tag = Tag.find_by(id: params[:id])

      # Check that tag exists.
      unless @tag
        respond_to do |format|
          flash.alert = "Tag not found."
          format.js { render js: "window.location.href = '#{root_url}" }
        end
      end 

      # Check permissions.
      if (@tag.hidden? || @tag.user !== current_user)
        respond_to do |format|
          flash.alert = "Forbidden to access Tag."
          format.js { render js: "window.location.href = '#{root_url}'" }
        end
      end
    end

    # Sanitize params.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
