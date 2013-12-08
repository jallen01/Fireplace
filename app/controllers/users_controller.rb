class UsersController < ApplicationController
  # Stores filter time frame in session.
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_context_overrides
    time_frame = params[:time_frame].to_sym
    time_frame = User::TIME_FRAMES.include?(time_frame) ? time_frame : :now
    location_id = current_user.get_locations.exists?(id: params[:location]) ? params[:location] : nil
    session[:context_overrides] = { time_frame: time_frame, location_id: location_id }

    @context = current_user_context

    respond_to do |format|
      format.js
    end
  end

  def update_location
    session[:utc_offset] = Integer(params[:utc_offset]) unless params[:utc_offset].nil?
    location = current_user.get_closest_location(params[:latitude], params[:longitude])
    session[:location_id] = location.id unless location.nil?
    
    @context = current_user_context
  end
end
