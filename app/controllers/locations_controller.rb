# Primary Author: Michelle Johnson (mchlljy)

class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:create]

  def create
    @new_location = current_user.create_location(location_params[:name])
    if !is_address_valid
      @new_location.errors[:base] << "Need to enter all address parts" 
    else
      #@new_location = current_user.create_location(location_params[:name])

      unless @new_location.errors.any?
        logger.debug "entered unless statement"
        @location = @new_location
        @new_location = Location.new(user: current_user)
        @location.update(location_params)
        flash[:list] = "Location Created"
      end

      respond_to do |format|
        format.js
      end
    end
  end
  
  def update
    if !is_address_valid
      @new_location.errors[:base] << "Need to enter all address parts" 
    else
      @location.update(location_params)
      flash[:list] = "Location Updated"
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @location_id = @location.id
    @location.destroy

    flash[:list] = "Location Deleted"

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

    def is_address_valid
      valid_address = (location_params[:street].blank? && location_params[:city].blank? && location_params[:state].blank? && location_params[:zip_code].blank?) || ( !location_params[:street].blank? && !location_params[:city].blank? && !location_params[:state].blank? && !location_params[:zip_code].blank?)
    end
end
