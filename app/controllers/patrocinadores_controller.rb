class PatrocinadoresController < ApplicationController
  before_action :set_patrocinador, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @patrocinador = Patrocinador.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @patrocinador = Patrocinador.new(patrocinador_params)
    if @patrocinador.save
      renderiza_crud_js(@patrocinador, 'Patrocinador criado com sucesso.')
    else
      renderiza_crud_js(@patrocinador)
    end
  end

  def update
    if @patrocinador.update(patrocinador_params)
      renderiza_crud_js(@patrocinador, 'Patrocinador alterado com sucesso.')
    else
      renderiza_crud_js(@patrocinador)
    end
  end

  def destroy
    @patrocinador.destroy
    renderiza_crud_js(@patrocinador, 'Patrocinador excluído com sucesso.')
  end

  def deleta_logo_patrocinador
    @deleta_logo_patrocinador = Patrocinador.find_by_id(params[:id])
    @deleta_logo_patrocinador.logo = nil
    if @deleta_logo_patrocinador.save
      renderiza_crud_js(@deleta_logo_patrocinador, 'Logo excluído com sucesso.')
    end
  end

  private

    def set_patrocinador
      @patrocinador = Patrocinador.find(params[:id])
    end

    def patrocinador_params
      params.require(:patrocinador).permit(:nome, :logo)
    end
end
