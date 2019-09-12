class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def log_in(user)
    session[:user_id]=user.id
    new_token=User.create_token
    cookies.permanent[:remember_token]=new_token
    cookies.permanent.signed[:user_id]=user.id
    user.update_attribute(:remember_digest, User.digest(new_token))
  end


end
