class Api::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/vnd.radd.v1' }

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200, :json => { :success => true, :info => "Logged in", :user => current_user }
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out
    render :status => 200, :json => { :success => true, :info => "Logged out", :csrfParam => request_forgery_protection_token, :csrfToken => form_authenticity_token }
  end

  def failure
    render :status => 401, :json => { :success => false, :info => "Login Credentials Failed" }
  end

  def show_current_user
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    #render :json => current_user.to_json(include: :users_role)
    roleNames = Array[]
    user_roles = current_user.users_role
    user_roles.each do |role|
      roleNames << role.roleName
    end
    langKey = current_user.langKey
    render :status => 200, :json => { :langKey => langKey, :roles => roleNames, :login => current_user.username, :user => current_user }
  end

  def register
    @user = User.new(username: params[:login], email: params[:email], password: params[:password], password_confirmation: params[:password], langKey: params[:langKey])
    @user.save
    if @user.id != nil
      @userRole = UsersRole.new(user_id: @user.id, roleName: "ROLE_USER")
      @userRole.save
    end

    if @user.valid?
      sign_in(@user)
      render :status => 201, :json => { :user => @user }
    else
      respond_with @user.errors, :location => api_users_path
    end
  end
end
