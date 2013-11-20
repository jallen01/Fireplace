class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_tag = Tag.new(user: current_user)
    @tags = current_user.tags
    @new_location = Location.new(user: current_user)
    @locations = current_user.locations
    @new_time_range = TimeRange.new(user: current_user)
    @time_ranges = current_user.time_ranges
    @new_day_range = DayRange.new(user: current_user)
    @day_ranges = current_user.day_ranges
  end
end
