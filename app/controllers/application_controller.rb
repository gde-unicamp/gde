class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :define_layout

  private

  def define_layout
    current_user ? 'user' : 'visitor'
  end
end
