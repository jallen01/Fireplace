class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_tag = Tag.new(user: current_user)
    @new_location = Location.new(user: current_user)
    @new_time_range = TimeRange.new(user: current_user)
    @new_day_range = DayRange.new(user: current_user)

    respond_to do |format|               
      format.js
    end
  end
end
