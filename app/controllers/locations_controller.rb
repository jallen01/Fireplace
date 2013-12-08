# Primary Author: Michelle Johnson (mchlljy)

class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:create]

  def create
    @new_location = current_user.create_location(location_params)
    
    unless @new_location.errors.any?
      @location = @new_location
      @new_location = Location.new(user: current_user)
    end

    respond_to do |format|
      format.js
    end
  end

  
  def update
    @location.update(location_params)
  end

  def destroy
    @location_id = @location.id
    @location.destroy

    respond_to do |format|
      format.js
    end
  end

  private 
    def location_params
      params.require(:location).permit(:name, :address_string, :latitude, :longitude)
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
