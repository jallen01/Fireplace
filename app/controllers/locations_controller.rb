# Primary Author: Michelle Johnson (mchlljy)

class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:create]


  def create
    puts "the params: #{location_params}"
    @new_location = current_user.create_location(location_params)
    
    unless @new_location.errors.any?
      @location = @new_location
      @new_location = Location.new(user: current_user)
      @location.update_locations(@metadata[:location_select])
      @locations = current_user.get_locations

    end

    respond_to do |format|
      format.js
    end

  end

  
  def update
    pars = location_params
    coords = Location.get_coordinates(pars)
    @location.update(:name => pars[:name], :latitude => coords[0], :longitude => coords[1], :address_hash => pars[:address_hash])
  end

  def destroy
    @location.destroy

    respond_to do |format|
      format.js
    end
  end

  private 
    # def edit_location_params
    #   params.require(:location)
    #     .permit(:id, :user_id, :name)
    #     .merge(street: params[:street], city: params[:city], zip: params[:zip], state: params[:state])
    # end

    def location_params
      params.require(:location)
            .permit(:name, :address_hash =>[:street, :city, :zip, :state])
    end

    def set_location
      @location = Location.find_by(id: params[:id])

      # Check that location exists.
      unless @location
        respond_to do |format|
          flash.alert = "Location not found."
          format.js { render js: "window.location.href = '#{home_url}" }
        end
      end 

      # Check that current user owns location.
      unless @location.user == current_user
        respond_to do |format|
          flash.alert = "Forbidden to access location."
          format.js { render js: "window.location.href = '#{home_url}'" }
        end
      end
    end
end
