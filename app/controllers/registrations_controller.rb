# Overrides default Devise::RegistrationsController to allow users to register users
class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create, :cancel]
  before_action :set_user, only: [:edit, :update]

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
      renderiza_crud_js(@user, 'Usuário criado com sucesso')
    else
      renderiza_crud_js(@user)
    end
  end

  def update
    if @user.update(registration_params)
      renderiza_crud_js(@user, 'Usuário alterado com sucesso')
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


  private

  def set_user
    @user = User.find(params[:id])
  end

  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
