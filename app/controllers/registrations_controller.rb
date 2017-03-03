# Overrides default Devise::RegistrationsController to allow users to register users
class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create, :cancel]
  before_action :set_user, only: [:edit, :update]
  before_action :set_role, only: [:new, :edit]

  def new
    @user = User.new
    mostra_modal(model: 'user')
  end

  def edit
    mostra_modal(model: 'user')
  end

  def create
    @user = User.new(registration_params)
    if @user.save
      renderiza_crud_js(@user, 'Usuário criado com sucesso', :user)
    else
      renderiza_crud_js(@user)
    end
  end

  def update

    ignora_password
    permite_role

    if @user.update(registration_params)
      renderiza_crud_js(@user, 'Usuário alterado com sucesso', :user)
    else
      renderiza_crud_js(@user)
    end
  end

  protected

  # The default sign_up method signs in new user upon creation
  # I just commented it out so you can see what the default method looks like
  def sign_up(resource_name, resource)
    # sign_in(resource_name, resource)
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end


  private

  def role_adder(role)
    if params[role] == "1"
      @user.grant(role)
    elsif params[role] == "0"
      @user.remove_role(role)
    end
  end

  def set_role
    @roles = [ :admin, :moderator, :other_role ]
  end

  def permite_role
    @roles = [ :admin, :moderator, :other_role ]
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts @roles
    @roles.each { |r| role_adder(r) }
  end

  def ignora_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :nome)
  end

end
