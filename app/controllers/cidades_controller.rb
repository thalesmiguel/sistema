class CidadesController < ApplicationController
  before_action :set_cidade, only: [:edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit]

  def index
    respond_to do |format|
      format.html
      format.json { render json: CidadeDatatable.new(view_context, { permitido: permitido? }) }
    end
  end

  def new
    @cidade = Cidade.new
    mostra_modal(@cidade)
  end

  def edit
    mostra_modal(@cidade)
  end

  def create
    @cidade = Cidade.new(cidade_params)
    if @cidade.save
      renderiza_crud_js(@cidade, 'Cidade criada com sucesso.')
    else
      renderiza_crud_js(@cidade)
    end
  end

  def update
    if @cidade.update(cidade_params)
      renderiza_crud_js(@cidade, 'Cidade alterada com sucesso.')
    else
      renderiza_crud_js(@cidade)
    end
  end

  def destroy
    @cidade.destroy
    renderiza_crud_js(@cidade, 'Cidade excluída com sucesso.')
  end

  private

    def set_cidade
      @cidade = Cidade.find(params[:id])
    end

    def set_estados
      @estados = Estado.all
    end

    def cidade_params
      params.require(:cidade).permit(:nome, :estado_id)
    end

end
