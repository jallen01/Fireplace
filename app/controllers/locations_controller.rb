# Primary Author: Michelle Johnson (mchlljy)

class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, except: [:index, :new, :create]

  def index
    @locations = Location.where("user_id = ? AND name != ?", current_user.id, "Current")
    @curr_location = Location.where(:name => "Current")
    
  end

  def new
    @location = current_user.locations.build #sets up new location to be saved

  end

  def create
    @location = Location.new_location(location_params)
    @location.user_id = current_user.id

    respond_to do |format|
      if @location.save
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    pars = edit_location_params
    coords = Geocoder.search("#{pars[:street]} #{pars[:city]} #{pars[:zip]} #{pars[:state]}")[0].coordinates
    @location.update(:name => pars[:name], :latitude => coords[0], :longitude => coords[1])
    
    respond_to do |format|
      if @location.save
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy

    respond_to do |format|
      format.js
    end
  end

  private 
    def edit_location_params
      params.require(:location)
        .permit(:id, :user_id, :name)
        .merge(street: params[:street], city: params[:city], zip: params[:zip], state: params[:state])
    end

    def location_params
      params.require(:location)
            .permit(:user_id, :name)
            .merge(street: params[:street], city: params[:city], zip: params[:zip], state: params[:state])
      # merge in street, city, zip, and state since they are passed in through a tag, and thus is not nested under location
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
