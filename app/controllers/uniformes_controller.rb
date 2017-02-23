class UniformesController < ApplicationController
  before_action :set_uniforme, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @uniforme = Uniforme.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @uniforme = Uniforme.new(uniforme_params)
    if @uniforme.save
      renderiza_crud_js(@uniforme, 'Uniforme criado com sucesso')
    else
      renderiza_crud_js(@uniforme)
    end
  end

  def update
    if @uniforme.update(uniforme_params)
      renderiza_crud_js(@uniforme, 'Uniforme alterado com sucesso')
    else
      renderiza_crud_js(@uniforme)
    end
  end

  def destroy
    @uniforme.destroy
    renderiza_crud_js(@uniforme, 'Uniforme excluído com sucesso')
  end

  private

    def set_uniforme
      @uniforme = Uniforme.find(params[:id])
    end

    def uniforme_params
      params.require(:uniforme).permit(:nome, :sexo)
    end

end
