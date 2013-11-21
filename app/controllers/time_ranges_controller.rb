class TimeRangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_range, except: [:create]
  before_action :parse_metadata, only: [:create, :update]

  def create
    @new_time_range = current_user.create_time_range(time_range_params[:name])
    
    unless @new_time_range.errors.any?
      @time_range = @new_time_range
      @new_time_range = TimeRange.new(user: current_user)
      @time_ranges = current_user.time_ranges

      @time_range.update_times(@metadata[:time_range_select])
    end
    
    respond_to do |format|
      format.js
    end
  end

  def update
    @time_range.update_times(@metadata[:time_range_select])
    @time_ranges = current_user.time_ranges
  end

  def destroy
    @time_range_id = @time_range.id
    @time_range.destroy
    @time_ranges = current_user.time_ranges

    respond_to do |format|
      format.js
    end
  end

  private

    def set_time_range
      @time_range = TimeRange.find_by(id: params[:id])

      # Check that time_range exists.
      unless @time_range
        respond_to do |format|
          flash.alert = "TimeRange not found."
          format.js { render js: "window.location.href = '#{home_url}" }
        end
      end 
    end

    # Sanitize params.
    def time_range_params
      params.require(:time_range).permit(:name)
    end

    def parse_metadata
      @metadata = {}
      
      @metadata[:time_range_select] = params["time_range_select"].map { |hour| SimpleTime.new(Integer(hour), 0) }
    end
end
