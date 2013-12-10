class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:create]

  def create
    @new_location = current_user.create_location(location_params[:name])
    @new_location.update(location_params)

    unless @new_location.errors.any?
      @location = @new_location
      @new_location = Location.new(user: current_user)
    end

    flash.now[:list] = "Location Created"

    respond_to do |format|
      format.js
    end
  end
  
  def update
    @location.update(location_params)

    unless @location.errors.any?
      flash[:list] = "Location Updated"
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @location_id = @location.id
    @location.destroy

    flash.now[:list] = "Location Deleted"

    respond_to do |format|
      format.js
    end
  end

  private 
    def location_params
      params.require(:location).permit(:name, :street, :city, :state, :zip_code, :latitude, :longitude)
    end

    def set_location
      @location = current_user.get_locations.find_by(id: params[:id])

      # Check that location exists.
      unless @location
        respond_to do |format|
          format.js { render status: 404 }
        end
      end 
    end
end
