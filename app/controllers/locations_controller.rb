class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:create]
  before_action :check_permissions

  def edit
    Location.ADDRESS_FIELDS_ALL.each { |field| self.instance_variable_set(field, self[field]) }
  end

  def create
    @new_location = current_user.add_location(location_params)
  end

  private 
    def set_location
      @location = Location.find_by(id: params[:id])

      # Check that location exists.
      unless @location
        respond_to do |format|
          flash.alert = "Location not found."
          format.js { render js: "window.location.href = '#{home_url}" }
        end
      end 
    end

    # Sanitize params.
    def location_params
      params.require(:location).permit(:name, :address)
    end

    def check_permissions
      unless @location.user == current_user
        respond_to do |format|
          flash.alert = "Forbidden to access location."
          format.js { render js: "window.location.href = '#{home_url}'" }
        end
      end
    end

end
