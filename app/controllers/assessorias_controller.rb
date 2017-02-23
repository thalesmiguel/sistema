class AssessoriasController < ApplicationController
  before_action :set_assessoria, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @assessoria = Assessoria.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @assessoria = Assessoria.new(assessoria_params)
    if @assessoria.save
      renderiza_crud_js(@assessoria, 'Assessoria criada com sucesso')
    else
      renderiza_crud_js(@assessoria)
    end
  end

  def update
    if @assessoria.update(assessoria_params)
      renderiza_crud_js(@assessoria, 'Assessoria alterada com sucesso')
    else
      renderiza_crud_js(@assessoria)
    end
  end

  def destroy
    @assessoria.destroy
    renderiza_crud_js(@assessoria, 'Assessoria excluída com sucesso')
  end

  def deleta_logo_assessoria
    @deleta_logo_assessoria = Assessoria.find_by_id(params[:id])
    @deleta_logo_assessoria.logo = nil
    if @deleta_logo_assessoria.save
      renderiza_crud_js(@deleta_logo_assessoria, 'Logo excluído com sucesso')
    end
  end

  private

    def set_assessoria
      @assessoria = Assessoria.find(params[:id])
    end

    def assessoria_params
      params.require(:assessoria).permit(:nome, :logo)
    end
end
