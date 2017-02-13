class LeilaoEventosController < ApplicationController
  before_action :set_leilao_evento, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @leilao_evento = LeilaoEvento.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @leilao_evento = LeilaoEvento.new(leilao_evento_params)
    if @leilao_evento.save
      renderiza_crud_js(@leilao_evento, 'Evento criado com sucesso.')
    else
      renderiza_crud_js(@leilao_evento)
    end
  end

  def update
    if @leilao_evento.update(leilao_evento_params)
      renderiza_crud_js(@leilao_evento, 'Evento alterado com sucesso.')
    else
      renderiza_crud_js(@leilao_evento)
    end
  end

  def destroy
    @leilao_evento.destroy
    renderiza_crud_js(@leilao_evento, 'Evento excluído com sucesso.')
  end

  private

    def set_leilao_evento
      @leilao_evento = LeilaoEvento.find(params[:id])
    end

    def leilao_evento_params
      params.require(:leilao_evento).permit(:nome, :data_inicio, :data_fim)
    end

end
