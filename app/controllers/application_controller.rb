class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_merchant?, :current_admin,
                :current_default?

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_default?
    current_user && current_user.default?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def current_admin
    current_user && current_user.admin?
  end

  def require_current_user
    render file: "/public/404" unless current_user
  end

  def require_merchant_employee
    render file: "/public/404" unless current_merchant?
  end

  def require_admin
    render file: "/public/404" unless current_admin
  end
end
