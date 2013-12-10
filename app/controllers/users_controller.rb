class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_context_overrides
    time_frame = params[:time_frame].to_sym
    time_frame = User::TIME_FRAMES.include?(time_frame) ? time_frame : :now
    location_id = current_user.get_locations.exists?(id: params[:location]) ? params[:location] : nil
    session[:context_overrides] = { time_frame: time_frame, location_id: location_id }

    @context = current_user_context
  end

  def update_utc_offset
    session[:utc_offset] = Integer(params[:utc_offset]) unless params[:utc_offset].nil?
    
    @context = current_user_context
  end
end
