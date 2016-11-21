class EstadosController < ApplicationController
  before_action :set_estado, only: [:edit, :update, :destroy]

  def index
    @estados = Estado.all.order(:nome)
  end

  def new
    @estado = Estado.new
    mostra_modal(@estado)
  end

  def edit
    mostra_modal(@estado)
  end

  def create
    @estado = Estado.new(estado_params)
    if @estado.save
      renderiza_crud_js(@estado, 'Estado criado com sucesso.')
    else
      renderiza_crud_js(@estado)
    end
  end

  def update
    if @estado.update(estado_params)
      renderiza_crud_js(@estado, 'Comprovante alterado com sucesso.')
    else
      renderiza_crud_js(@estado)
    end
  end

  def destroy
    @estado.destroy
    renderiza_crud_js(@estado, 'Estado excluído com sucesso.')
  end

  private

    def set_estado
      @estado = Estado.find(params[:id])
    end

    def estado_params
      params.require(:estado).permit(:nome, :sigla)
    end
end
