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
      renderiza_crud_js(@pagamento_condicao, 'Condição de pagamento criada com sucesso.')
    else
      renderiza_crud_js(@pagamento_condicao)
    end
  end

  def update
    if captacoes_corretas
      if @pagamento_condicao.update(pagamento_condicao_params)
        # renderiza_crud_js(@pagamento_condicao, 'Condição de pagamento alterada com sucesso.')
        respond_to do |format|
          format.js { render file: 'ajax/pagamento_condicoes/mostra_parcelas.js.erb' }
        end
      else
        renderiza_crud_js(@pagamento_condicao)
      end
    else
      flash[:warning] = "<ul>A quantidade de captações está incorreta:<li><ins>Captações Necessárias</ins>: #{pagamento_condicao_params[:captacoes].to_i}</li><li><ins>Captações Atuais</ins>: #{captacoes_atuais}</li></ul>"
      renderiza_erro_controller_js(@pagamento_condicao)
    end
  end

  def destroy
    @pagamento_condicao.destroy
    renderiza_crud_js(@pagamento_condicao, 'Condição de pagamento excluída com sucesso.')
  end

  private

    def captacoes_corretas
      pagamento_condicao_params[:captacoes].to_i == captacoes_atuais
    end

    def captacoes_atuais
      pagamento_condicao_params[:pagamento_parcelas_attributes].map { |k, v| v[:captacoes].to_i }.reduce(0, :+) unless pagamento_condicao_params[:pagamento_parcelas_attributes].blank?
    end

    def set_pagamento_condicao
      @pagamento_condicao = PagamentoCondicao.find(params[:id])
    end

    def pagamento_condicao_params
      params.require(:pagamento_condicao).permit(:nome, :tipo, :captacoes, :parcelas, :frequencia, :entrada,
                                                 pagamento_parcelas_attributes: [:id, :parcela, :captacoes, :vencimento])
    end
end
