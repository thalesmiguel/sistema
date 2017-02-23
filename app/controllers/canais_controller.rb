class CanaisController < ApplicationController
  before_action :set_canal, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @canal = Canal.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @canal = Canal.new(canal_params)
    if @canal.save
      renderiza_crud_js(@canal, 'Canal criado com sucesso')
    else
      renderiza_crud_js(@canal)
    end
  end

  def update
    if @canal.update(canal_params)
      renderiza_crud_js(@canal, 'Canal alterado com sucesso')
    else
      renderiza_crud_js(@canal)
    end
  end

  def destroy
    @canal.destroy
    renderiza_crud_js(@canal, 'Canal excluído com sucesso')
  end

  def deleta_logo_canal
    @deleta_logo_canal = Canal.find_by_id(params[:id])
    @deleta_logo_canal.logo = nil
    if @deleta_logo_canal.save
      renderiza_crud_js(@deleta_logo_canal, 'Logo excluído com sucesso')
    end
  end

  private

    def set_canal
      @canal = Canal.find(params[:id])
    end

    def canal_params
      params.require(:canal).permit(:nome, :observacao, :inf_transmissao, :logo)
    end
end
