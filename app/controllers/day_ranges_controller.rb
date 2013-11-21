class DayRangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_day_range, except: [:create]

  def create
    @new_day_range = current_user.create_day_range(day_range_params[:name])
    
    unless @new_day_range.errors.any?
      @day_range = @new_day_range
      @new_day_range = DayRange.new(user: current_user)
      @day_ranges = current_user.get_day_ranges

      @day_range.update_days(@metadata[:day_range_select])
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @day_range.update(day_range_params)
    @day_range.update_days(@metadata[:day_range_select])

    @day_ranges = current_user.get_day_ranges
  end

  def destroy
    @day_range.destroy
    @day_ranges = current_user.get_day_ranges

    respond_to do |format|
      format.js
    end
  end

  private

    def set_day_range
      @day_range = DayRange.find_by(id: params[:id])

      # Check that day_range exists.
      unless @day_range
        respond_to do |format|
          flash.alert = "DayRange not found."
          format.js { render js: "window.location.href = '#{root_url}" }
        end
      end 

      # Check permissions.
      if (@day_range.hidden? || @day_rage !== current_user)
        respond_to do |format|
          flash.alert = "Forbidden to access DayRange."
          format.js { render js: "window.location.href = '#{root_url}" }
        end
      end 
    end

    # Sanitize params.
    def day_range_params
      params.require(:day_range).permit(:name)
    end
end
