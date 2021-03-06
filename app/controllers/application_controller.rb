# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def log_in(user)
    session[:user_id] = user.id
    new_token = User.create_token
    cookies.permanent[:remember_token] = new_token
    cookies.permanent.signed[:user_id] = user.id
    user.update_attribute(:remember_digest, User.digest(new_token))
    current_user
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(:id, cookies.signed[:user_id])
      @current_user ||= user if user &.authenticated?(cookies[:remember_token])
    end
  end

  def log_out(user)
    session.delete(:user_id)
    user.update_attribute(:remember_digest, nil)
    @current_user = nil
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end

  def logged_in?
    !current_user.nil?
  end
end
