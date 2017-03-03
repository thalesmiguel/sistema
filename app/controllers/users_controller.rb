class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def destroy
    @user.destroy
    renderiza_crud_js(@user, 'Usuário excluído com sucesso')
  end

  private

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Somente Para Admistradores!!!'
  end

  def set_user
    @user = User.find(params[:id])
  end
end
