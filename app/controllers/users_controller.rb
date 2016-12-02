class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context, { permitido: permitido? }) }
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuário excluído.' }
    end
  end

  private

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end

  def set_user
    @user = User.find(params[:id])
  end


end
