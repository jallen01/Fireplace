class DayRangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_day_range, except: [:create]

  def create
    @new_day_range = current_user.create_day_range(day_range_params[:name])
    @new_day_range.update(day_range_params)
    
    unless @new_day_range.errors.any?
      @day_range = @new_day_range
      @new_day_range = DayRange.new(user: current_user)
      
      @day_range.update_days(@metadata[:day_range_select])
      flash.now[:list] = "Day Range Created"
    end
  end

  def update
    @day_range.update(day_range_params)
    

    unless @day_range.errors.any?
      @day_range.update_days(@metadata[:day_range_select])
      flash.now[:list] = "Day Range Updated"
    end
  end

  def destroy
    @day_range_id = @day_range.id
    @day_range.destroy

    flash.now[:list] = "Day Range Deleted"
  end

  private

    def set_day_range
      @day_range = current_user.get_day_ranges.find_by(id: params[:id])

      # Check that day_range exists.
      unless @day_range
        respond_to do |format|
          format.js { render status: 404 }
        end
      end
    end

    # Sanitize params.
    def day_range_params
      params.require(:day_range).permit(:name)
    end
end
