class FuncoesController < ApplicationController
  before_action :set_funcao, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @funcao = Funcao.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @funcao = Funcao.new(funcao_params)
    if @funcao.save
      renderiza_crud_js(@funcao, 'Função criada com sucesso.')
    else
      renderiza_crud_js(@funcao)
    end
  end

  def update
    if @funcao.update(funcao_params)
      renderiza_crud_js(@funcao, 'Função alterada com sucesso.')
    else
      renderiza_crud_js(@funcao)
    end
  end

  def destroy
    @funcao.destroy
    renderiza_crud_js(@funcao, 'Função excluída com sucesso.')
  end

  private

    def set_funcao
      @funcao = Funcao.find(params[:id])
    end

    def funcao_params
      params.require(:funcao).permit(:nome)
    end

end
