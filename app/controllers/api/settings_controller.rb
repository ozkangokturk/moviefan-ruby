class Api::SettingsController < Api::BaseController
  before_filter :set_current_user
  respond_to :json

  def saveSettings
    @current_user = User.current
    @current_user.update_attributes!(settings_params)
    render :status => 200, :json => { :message => "success"}
  end

  def changePassword
    @current_user = User.current
    p params[:_json]
    @current_user.update_attributes!(password: params[:_json], password_confirmation: params[:_json])
    render :status => 200, :json => { :message => "success"}
  end

  def settings_params
    params.permit(:email, :firstName, :lastName, :langKey)
  end


end
