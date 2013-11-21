class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :parse_metadata, only: [:create, :update]

  def camel_to_underscore(str)
    str.gsub(/[a-zA-Z](?=[A-Z])/, '\0_').downcase
  end
  helper_method :camel_to_underscore

  def camel_to_dash(str)
    str.gsub(/[a-zA-Z](?=[A-Z])/, '\0-').downcase
  end
  helper_method :camel_to_dash

  def camel_to_space
    str.gsub(/[a-zA-Z](?=[A-Z])/, '\0 ')
  end
  helper_method :camel_to_space

  protected

  # Add user name to Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
  end

  def parse_metadata
    @metadata = {}

    @metadata[:tags] = (params[:tags] || []).map { |id| Tag.find_by(id: id) }.compact

    @metadata[:time_range_select] = (params["time_range_select"] || []).map { |hour| SimpleTime.new(Integer(hour), 0) }
    @metadata[:day_range_select] = (params["day_range_select"] || []).map { |day| SimpleDay.new(Integer(day)) }

    @metadata[:time_ranges] = (params[:time_ranges] || []).map { |id| TimeRange.find_by(id: id) }.compact
    @metadata[:day_ranges] = (params[:day_ranges] || []).map { |id| DayRange.find_by(id: id) }.compact
  end
end
