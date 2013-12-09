class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :parse_metadata, only: [:create, :update]

  protected

  # Add user name to Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
  end

  def current_user_context
    location_id = session[:context_overrides][:location_id] || session[:location_id]
    location = current_user.get_locations.find_by(id: location_id)

    time_frame = session[:context_overrides][:time_frame] || :now
    
    current_user.get_context(time_frame, location, session[:utc_offset])
  end
  helper_method :current_user_context

  def parse_metadata
    @metadata = {}

    @metadata[:tags] = (params[:tags] || []).map { |id| current_user.get_tags.find_by(id: id) }.compact

    if @metadata[:tags].empty?
      @metadata[:time_ranges] = (params[:time_ranges] || []).map { |id| current_user.get_time_ranges.find_by(id: id) }.compact
      if @metadata[:time_ranges].empty?
        @metadata[:time_range_select] = (params["time_range_select"] || []).map { |hour| SimpleTime.new(Integer(hour), 0) }
      else
        @metadata[:time_range_select] = []
      end

      @metadata[:day_ranges] = (params[:day_ranges] || []).map { |id| current_user.get_day_ranges.find_by(id: id) }.compact
      if @metadata[:day_ranges].empty?
        @metadata[:day_range_select] = (params["day_range_select"] || []).map { |day| SimpleDay.new(Integer(day)) }
      else
        @metadata[:day_range_select] = []
      end

      @metadata[:locations] = (params[:locations] || []).map { |id| current_user.get_locations.find_by(id: id) }.compact
    else
      [:time_ranges, :time_range_select, :day_ranges, :day_range_select, :locations].each do |key|
        @metadata[key] = []
      end
    end
  end
end
