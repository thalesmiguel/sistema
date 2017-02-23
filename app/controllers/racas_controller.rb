class RacasController < ApplicationController
  before_action :set_raca, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @raca = Raca.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @raca = Raca.new(raca_params)
    if @raca.save
      renderiza_crud_js(@raca, 'Raça criada com sucesso')
    else
      renderiza_crud_js(@raca)
    end
  end

  def update
    if @raca.update(raca_params)
      renderiza_crud_js(@raca, 'Raça alterada com sucesso')
    else
      renderiza_crud_js(@raca)
    end
  end

  def destroy
    @raca.destroy
    renderiza_crud_js(@raca, 'Raça excluída com sucesso')
  end

  private

    def set_raca
      @raca = Raca.find(params[:id])
    end

    def raca_params
      params.require(:raca).permit(:nome, :especie)
    end
end
