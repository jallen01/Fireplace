class UsersController < ApplicationController
  # Stores filter time frame in session.
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_time_frame
    time_frame = params[:time_frame]
    session[:time_frame] = time_frame if Task::TIME_FRAMES.include?(time_frame)

    filter_tasks

    respond_to do |format|
      format.js
    end
  end

  def update_location
  end
end
