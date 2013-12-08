class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, except: [:index, :new, :create]

  def create
    @new_tag = current_user.create_tag(tag_params[:name])

    unless @new_tag.errors.any?
      @tag = @new_tag
      @new_tag = Tag.new(user: current_user)

      @tag.update_metadata(@metadata)
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @tag.update(tag_params)
    @tag.update_metadata(@metadata)
  end

  def destroy
    @tag_id = @tag.id
    @tag.destroy

    respond_to do |format|
      format.js
    end
  end

  private

    def set_tag
      @tag = current_user.get_tags.find_by(id: params[:id])

      # Check that tag exists.
      unless @tag
        respond_to do |format|
          format.js { render status: 404 }
        end
      end
    end

    # Sanitize params.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
