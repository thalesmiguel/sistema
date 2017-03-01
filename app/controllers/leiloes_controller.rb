class LeiloesController < ApplicationController
  before_action :set_leilao, only: [:edit, :update, :destroy, :seleciona_leilao]

  def index
    respond_to do |format|
      format.js { render file: "ajax/leiloes/lista_leiloes.js.erb" }
      format.json { renderiza_datatable }
    end
  end

  def new
    @leilao = Leilao.new
    respond_to do |format|
      format.js { render file: "ajax/leiloes/mostra_leilao.js.erb" }
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def create
    @leilao = Leilao.new(leilao_params)

    if @leilao.save
      respond_to do |format|
        format.js { render file: "ajax/leiloes/mostra_novo_leilao.js.erb" }
      end
    else
      renderiza_crud_js(@leilao)
    end
  end

  def update
    if @leilao.update(leilao_params)
      renderiza_crud_js(@leilao, 'Leilão alterado com sucesso')
    else
      renderiza_crud_js(@leilao)
    end
  end

  def destroy
    @leilao.destroy
    renderiza_crud_js(@leilao, 'Leilão excluído com sucesso')
  end

  def seleciona_leilao
    session[:leilao_id] = @leilao.id
    respond_to do |format|
      format.js { render file: "ajax/leiloes/seleciona_leilao.js.erb" }
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
