# Primary Author: Michelle Johnson (mchlljy)

class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:create]

  def create
    @new_location = current_user.create_location(location_params[:name])

    #valid_address = (street.blank? && city.blank? && state.blank? && zip_code.blank?) || ( !street.blank? && !city.blank? && !state.blank? && !zip_code.blank?)
    #logger.debug("Is street blank?: #{street.blank?}")
    #logger.debug("Is city blank?: #{city.blank?}")
    #logger.debug("Is state blank?: #{state.blank?}")
    #logger.debug("Is zip code blank?: #{zip_code.blank?}")

    unless @new_location.errors.any?
      @location = @new_location
      @new_location = Location.new(user: current_user)
      @location.update(location_params)
    end

    respond_to do |format|
      format.js
    end
  end

  
  def update
    unless @location.errors.any?
      @location.update(location_params)
    end
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
