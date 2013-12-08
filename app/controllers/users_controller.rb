class UsersController < ApplicationController
  # Stores filter time frame in session.
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_context_overrides
    time_frame = params[:time_frame].to_sym
    time_frame = User::TIME_FRAMES.include?(time_frame) ? time_frame : nil
    location = current_user.get_locations.exists?(id: params[:location]) ? params[:location] : nil

    session[:context_overrides] = {time_frame: time_frame, location: location}
    
    @context = current_user.get_context(session[:context_overrides], session[:location], session[:utc_offset])

    respond_to do |format|
      format.js
    end
  end

  def update_location
    session[:utc_offset] = Integer(params[:utc_offset]) unless session[:utc_offset].nil?

    session[:location] = current_user.get_closest_location(params[:latitude], [:longitude]) unless (session[:latitude].nil? || session[:longitude].nil?)
    
    @context = current_user.get_context(session[:context_overrides], session[:location], session[:utc_offset])
  end
end
