class BandeirasController < ApplicationController
  before_action :set_bandeira, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @bandeira = Bandeira.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @bandeira = Bandeira.new(bandeira_params)
    if @bandeira.save
      renderiza_crud_js(@bandeira, 'Bandeira criada com sucesso.')
    else
      renderiza_crud_js(@bandeira)
    end
  end

  def update
    if @bandeira.update(bandeira_params)
      renderiza_crud_js(@bandeira, 'Bandeira alterada com sucesso.')
    else
      renderiza_crud_js(@bandeira)
    end
  end

  def destroy
    @bandeira.destroy
    renderiza_crud_js(@bandeira, 'Bandeira excluída com sucesso.')
  end

  def deleta_logo
    @deleta_logo_bandeira = Bandeira.find_by_id(params[:id])
    @deleta_logo_bandeira.logo = nil
    if @deleta_logo_bandeira.save
      renderiza_crud_js(@deleta_logo_bandeira, 'Logo excluído com sucesso.')
    end
  end

  private

    def set_bandeira
      @bandeira = Bandeira.find(params[:id])
    end

    def bandeira_params
      params.require(:bandeira).permit(:nome, :sigla, :cor, :logo)
    end

end
