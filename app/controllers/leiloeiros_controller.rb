class LeiloeirosController < ApplicationController
  before_action :set_leiloeiro, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @estados.first)

    @leiloeiro = Leiloeiro.new
    mostra_modal
  end

  def edit
    @estados = Estado.all
    @cidades = @leiloeiro.cidade ? Cidade.where("estado_id = ?", @leiloeiro.cidade.estado_id) : Cidade.where("estado_id = ?", @estados.first)

    mostra_modal
  end

  def create
    @leiloeiro = Leiloeiro.new(leiloeiro_params)
    if @leiloeiro.save
      renderiza_crud_js(@leiloeiro, 'Leiloeiro criado com sucesso.')
    else
      renderiza_crud_js(@leiloeiro)
    end
  end

  def update
    if @leiloeiro.update(leiloeiro_params)
      renderiza_crud_js(@leiloeiro, 'Leiloeiro alterado com sucesso.')
    else
      renderiza_crud_js(@leiloeiro)
    end
  end

  def destroy
    @leiloeiro.destroy
    renderiza_crud_js(@leiloeiro, 'Leiloeiro excluído com sucesso.')
  end

  def deleta_foto_leiloeiro
    @deleta_foto_leiloeiro = Leiloeiro.find_by_id(params[:id])
    @deleta_foto_leiloeiro.foto = nil
    if @deleta_foto_leiloeiro.save
      renderiza_crud_js(@deleta_foto_leiloeiro, 'Foto excluída com sucesso.')
    end
  end

  private

    def set_leiloeiro
      @leiloeiro = Leiloeiro.find(params[:id])
    end

    def leiloeiro_params
      params.require(:leiloeiro).permit(:nome_contrato, :razao_social, :cpf, :cnpj, :sindicato, :endereco, :cep, :email,
                                        :telefone, :fax, :sigla, :foto, :comissao_elite, :comissao_virtual, :comissao_corte,
                                        :comissao_shopping, :comissao_contrato, :cliente_id, :cidade_id)
    end
end
