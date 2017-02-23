class BancosController < ApplicationController
  before_action :set_banco, only: [:edit, :update, :destroy]

  def index
    @bancos = Banco.all
    respond_to do |format|
      format.json { render json: BancoDatatable.new(view_context, { bancos: @bancos, permitido: permitido? }) }
      format.html
    end
  end

  def new
    @banco = Banco.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @banco = Banco.new(banco_params)
    if @banco.save
      renderiza_crud_js(@banco, 'Banco criado com sucesso')
    else
      renderiza_crud_js(@banco)
    end
  end

  def update
    if @banco.update(banco_params)
      renderiza_crud_js(@banco, 'Banco alterado com sucesso')
    else
      renderiza_crud_js(@banco)
    end
  end

  def destroy
    @banco.destroy
    renderiza_crud_js(@banco, 'Banco excluído com sucesso')
  end

  def lista_bancos
    mostra_modal(caminho: "lista_bancos")
  end

  private

    def set_banco
      @banco = Banco.find(params[:id])
    end

    def banco_params
      params.require(:banco).permit(:codigo, :nome)
    end

end
