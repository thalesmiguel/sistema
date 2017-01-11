class FazendasController < ApplicationController
  before_action :set_fazenda, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_fazenda = params[:cliente_id]
    @fazendas = Fazenda.where(cliente_id: params[:cliente_id])
    respond_to do |format|
      format.json { render json: FazendaDatatable.new(view_context, { fazendas: @fazendas, permitido: permitido? }) }
      format.js { mostra_fazendas(@fazendas) }
    end
  end

  def new
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @estados.first)

    @cliente = Cliente.find(params[:cliente_id])
    @fazenda = @cliente.fazendas.build
    mostra_modal(caminho: "clientes/fazendas/form")
  end

  def edit
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @fazenda.cidade.estado_id)

    mostra_modal(caminho: "clientes/fazendas/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @fazenda = @cliente.fazendas.new(fazenda_params)
    # @fazenda = Fazenda.new(fazenda_params)
    if @fazenda.save
      renderiza_crud_js(@fazenda, 'Fazenda criado com sucesso.')
    else
      renderiza_crud_js(@fazenda)
    end
  end

  def update
    if @fazenda.update(fazenda_params)
      renderiza_crud_js(@fazenda, 'Fazenda alterado com sucesso.')
    else
      renderiza_crud_js(@fazenda)
    end
  end

  def destroy
    @fazenda.destroy
    renderiza_crud_js(@fazenda, 'Fazenda excluído com sucesso.')
  end

  private

    def mostra_fazendas(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/fazendas/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_fazenda
      @fazenda = Fazenda.find(params[:id])
      @cliente = @fazenda.cliente
    end

    def fazenda_params
      params.require(:fazenda).permit(:nome, :cep, :tipo, :endereco, :area, :observacao, :inscricao_estadual, :cnpj_fazenda,
                                      :incra, :cnpj_produtor, :faz_terceiro, :nome_nf, :cpf_cnpj_nf, :ativo, :cidade_id, :cliente_id)
    end
end
