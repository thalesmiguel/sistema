class CidadesController < ApplicationController
  before_action :set_cidade, only: [:edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @cidade = Cidade.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @cidade = Cidade.new(cidade_params)
    if @cidade.save
      renderiza_crud_js(@cidade, 'Cidade criada com sucesso')
    else
      renderiza_crud_js(@cidade)
    end
  end

  def update
    if @cidade.update(cidade_params)
      renderiza_crud_js(@cidade, 'Cidade alterada com sucesso')
    else
      renderiza_crud_js(@cidade)
    end
  end

  def destroy
    @cidade.destroy
    renderiza_crud_js(@cidade, 'Cidade excluída com sucesso')
  end

  def update_cidades
    @cidades = Cidade.where("estado_id = ?", params[:estado_id]).order(:nome)
    respond_to do |format|
      format.js { render file: "ajax/application/update_cidades.js.erb", locals: { model: params[:model] }  }
    end
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
