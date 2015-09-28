# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end
  
  def require_user!
    render 'errors/forbidden.html.erb', :status => :forbidden unless signed_in?
  end
  
  def require_church!
    render 'errors/forbidden.html.erb', :status => :forbidden unless signed_in? && current_user.church
  end
  
  def not_found
    render 'errors/not_found.html.erb', :status => :not_found
  end

  def fields_to_json(fields, params)
    Rails.logger.info("Params #{params} - fields #{fields}")
    if params
      allowed_names = fields.map { |field| field[:name] }
      Rails.logger.info("Allowed names #{allowed_names}")
      params.select { |key,_| allowed_names.include? key }
    else
      nil
    end
  end
  
  helper_method :current_user, :signed_in?, :not_found
end

