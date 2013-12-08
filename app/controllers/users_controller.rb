class UsersController < ApplicationController
  # Stores filter time frame in session.
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_context
    time_frame = params[:time_frame].to_sym
    session[:time_frame] = time_frame if User::TIME_FRAMES.include?(time_frame)
    
    @user_context = current_user.get_context(session[:time_frame], session[:utc_offset], session[:location])

    respond_to do |format|
      format.js
    end
  end

  def update_location
    unless session[:utc_offset].nil?
      session[:utc_offset] = Integer(params[:utc_offset])
    end

    unless params[:latitude].nil?

    end

    @user_context = current_user.get_context(session[:time_frame], session[:utc_offset], session[:location])
  end
end
