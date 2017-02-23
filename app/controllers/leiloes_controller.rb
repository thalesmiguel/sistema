class LeiloesController < ApplicationController
  before_action :set_leilao, only: [:edit, :update, :destroy, :altera_status]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @leilao = Leilao.new
    respond_to do |format|
      format.js { render file: "ajax/leilaos/mostra_leilao.js.erb" }
    end
  end

  def edit
    respond_to do |format|
      format.js { render file: "ajax/leilaos/mostra_leilao.js.erb" }
    end
  end

  def create
    @leilao = Leilao.new(leilao_params)
    @leilao.marketing_tipos << params[:marketing_tipos] #rever

    if @leilao.save
      respond_to do |format|
        format.js { render file: "ajax/leilaos/mostra_novo_leilao.js.erb" }
      end
    else
      renderiza_crud_js(@leilao)
    end
  end

  def update
    if @leilao.update(leilao_params)
      renderiza_crud_js(@leilao, 'Leilao alterado com sucesso')
    else
      renderiza_crud_js(@leilao)
    end
  end

  def destroy
    @leilao.destroy
    # renderiza_crud_js(@leilao, 'Leilao excluído com sucesso')
    respond_to do |format|
      format.js { render file: "ajax/leilaos/mostra_pesquisa.js.erb" }
    end
  end

  def altera_status
    @leilao.ativo = !@leilao.ativo
    @leilao.save
    respond_to do |format|
      format.js { render file: "ajax/leilaos/mostra_leilao.js.erb" }
    end
  end

  private

    def set_leilao
      @leilao = Leilao.find(params[:id])
    end

    def leilao_params
      params.require(:leilao).permit(:categoria, :modalidade, :nome, :data_inicio, :data_fim, :nome_agenda, :nome_site,
                                     :cidade_id, :tipo, :situacao, :testemunha_1_id, :testemunha_2_id, :leilao_anterior_id,
                                     :subtipo_lotes_id, :observacao_nota_mapa, :logo, :leilao_evento_id)
    end

end
