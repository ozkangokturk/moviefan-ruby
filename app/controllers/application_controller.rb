class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless: -> { request.format.json? }
  after_filter :set_csrf_cookie_for_ng

  before_action :configure_permitted_parameters, if: :devise_controller?

  def intercept_html_requests
    redirect_to('/') if request.format == Mime::HTML
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    message = 'Rails CSRF token error, please try again'
    render_with_protection(message.to_json, {:status => :unprocessable_entity})
  end

  def render_with_protection(object, parameters = {})
    render parameters.merge(content_type: 'application/json', text: ")]}',\n" + object.to_json)
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def createLink(totalElements, totalPages, baseUrl, offset, limit)
    @link = ''
    if offset == nil or offset < 1
      offset = 1
    end
    if limit == nil or limit > 100
      limit = 20
    end
    if offset < totalPages
      @link = "<" + baseUrl + "?page=" + (offset + 1).to_s + "&per_page=" + limit.to_s + ">; rel=\"next\","
    end
    if offset > 1
      @link += "<" + baseUrl + "?page=" + (offset - 1).to_s + "&per_page=" + limit.to_s + ">; rel=\"prev\","
    end
    @link += "<" + baseUrl + "?page=" + totalPages.to_s + "&per_page=" + limit.to_s + ">; rel=\"last\","
    @link += "<" + baseUrl + "?page=1&per_page=" + limit.to_s + ">; rel=\"first\""
  end

  def set_current_user
    User.current = current_user
  end
end
