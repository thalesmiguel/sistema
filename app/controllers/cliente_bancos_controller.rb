class ClienteBancosController < ApplicationController
  before_action :set_cliente_banco, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_cliente_banco = params[:cliente_id]
    @cliente_bancos = ClienteBanco.where(cliente_id: params[:cliente_id])
    respond_to do |format|
      format.json { render json: ClienteBancoDatatable.new(view_context, { cliente_bancos: @cliente_bancos, permitido: permitido? }) }
      format.js { mostra_cliente_bancos(@cliente_bancos) }
    end
  end

  def new
    @bancos = Banco.all
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @estados.first)

    @cliente = Cliente.find(params[:cliente_id])
    @cliente_banco = @cliente.cliente_bancos.build
    mostra_modal(caminho: "clientes/cliente_bancos/form")
  end

  def edit
    @bancos = Banco.all
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @cliente_banco.cidade.estado_id)

    mostra_modal(caminho: "clientes/cliente_bancos/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_banco = @cliente.cliente_bancos.new(cliente_banco_params)

    if @cliente_banco.save
      renderiza_crud_js(@cliente_banco, 'Banco criado com sucesso.')
    else
      renderiza_crud_js(@cliente_banco)
    end
  end

  def update
    if @cliente_banco.update(cliente_banco_params)
      renderiza_crud_js(@cliente_banco, 'Banco alterado com sucesso.')
    else
      renderiza_crud_js(@cliente_banco)
    end
  end

  def destroy
    @cliente_banco.destroy
    renderiza_crud_js(@cliente_banco, 'Banco excluído com sucesso.')
  end

  private

    def mostra_cliente_bancos(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/cliente_bancos/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_cliente_banco
      @cliente_banco = ClienteBanco.find(params[:id])
      @cliente = @cliente_banco.cliente
    end

    def cliente_banco_params
      params.require(:cliente_banco).permit(:banco_id, :agencia, :conta_corrente, :cidade_id, :data_abertura_conta, :observacao,
                                            :correntista_nome, :correntista_cpf_cnpj, :primario, :ativo, :cliente_id)
    end
end
