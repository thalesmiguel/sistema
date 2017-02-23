class PagamentoCondicoesController < ApplicationController
  before_action :set_pagamento_condicao, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @pagamento_condicao = PagamentoCondicao.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @pagamento_condicao = PagamentoCondicao.new(pagamento_condicao_params)
    if @pagamento_condicao.save
      respond_to do |format|
        format.js { render file: 'ajax/pagamento_condicoes/mostra_parcelas.js.erb', locals: { notice: 'Condição de pagamento criada com sucesso' } }
      end
    else
      renderiza_crud_js(@pagamento_condicao)
    end
  end

  def update
    if @pagamento_condicao.update(pagamento_condicao_params)
      respond_to do |format|
        format.js { render file: 'ajax/pagamento_condicoes/mostra_parcelas.js.erb', locals: { notice: "Condição de pagamento alterada com sucesso" } }
      end
    else
      renderiza_crud_js(@pagamento_condicao)
    end
  end

  def destroy
    @pagamento_condicao.destroy
    renderiza_crud_js(@pagamento_condicao, 'Condição de pagamento excluída com sucesso')
  end

  private
    def set_pagamento_condicao
      @pagamento_condicao = PagamentoCondicao.find(params[:id])
    end

    def pagamento_condicao_params
      params.require(:pagamento_condicao).permit(:nome, :tipo, :captacoes, :parcelas, :frequencia, :entrada,
                                                 pagamento_parcelas_attributes: [:id, :parcela, :captacoes, :vencimento])
    end
end
