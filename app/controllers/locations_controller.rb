class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:index, :new, :create]

  def index
  end

  def new
  end

  def create
    @new_location = current_user.add_location(params[:name], params[:address])
  end

  def show
  end

  def edit
  end

  def update
    @location.update(location_params)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @location.destroy

    respond_to do |format|
      format.js
    end
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

      # Check that current user owns location.
      unless @location.user == current_user
        respond_to do |format|
          flash.alert = "Forbidden to access location."
          format.js { render js: "window.location.href = '#{home_url}'" }
        end
      end
    end
end
