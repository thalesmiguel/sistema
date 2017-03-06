class LeilaoObservacoesController < ApplicationController
  before_action :set_leilao_observacao, only: [:edit, :update, :destroy, :altera_status]

  def index
    @leilao = params[:leilao_id]
    @leilao_observacoes = LeilaoObservacao.where(leilao_id: @leilao)
    respond_to do |format|
      format.json { render json: LeilaoObservacaoDatatable.new(view_context, { leilao: @leilao, permitido: permitido? }) }
      format.js { mostra_leilao_observacoes(@leilao_observacoes) }
    end
  end

  def new
    @leilao = Leilao.find(params[:leilao_id])
    @leilao_observacao = @leilao.leilao_observacoes.build
    mostra_modal(caminho: "leiloes/leilao_observacoes/form")
  end

  def edit
    mostra_modal(caminho: "leiloes/leilao_observacoes/form")
  end

  def create
    @leilao = Leilao.find(params[:leilao_id])

    @leilao_observacao = @leilao.leilao_observacoes.new(leilao_observacao_params)
    if @leilao_observacao.save
      renderiza_crud_js(@leilao, 'Observação criada com sucesso')
    else
      renderiza_crud_js(@leilao_observacao)
    end
  end

  def update
    if @leilao_observacao.update(leilao_observacao_params)
      renderiza_crud_js(@leilao_observacao, 'Observação alterada com sucesso')
    else
      renderiza_crud_js(@leilao_observacao)
    end
  end

  def destroy
    @leilao_observacao.destroy
    renderiza_crud_js(@leilao_observacao, 'Observação excluída com sucesso')
  end

  def altera_status
    @leilao_observacao.ativo = !@leilao_observacao.ativo
    @leilao_observacao.save
    renderiza_crud_js(@leilao_observacao, 'Observação alterada com sucesso')
  end

  private

    def mostra_leilao_observacoes(obj, model = params[:controller].singularize)
      render file: "ajax/leiloes/leilao_observacoes/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_leilao_observacao
      @leilao_observacao = LeilaoObservacao.find(params[:id])
      @leilao = @leilao_observacao.leilao
    end

    def leilao_observacao_params
      params.require(:leilao_observacao).permit(:descricao, :user_id, :ativo, :leilao_id)
    end

end
