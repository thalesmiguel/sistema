class ClientesController < ApplicationController
  before_action :set_cliente, only: [:edit, :update, :destroy]

  def index
    @cliente = Cliente.new

    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @cliente = Cliente.new
    respond_to do |format|
      format.js { render file: "ajax/clientes/mostra_cliente.js.erb" }
    end
  end

  def edit
    # mostra_modal(@cliente)
    respond_to do |format|
      format.js { render file: "ajax/clientes/mostra_cliente.js.erb" }
    end
  end

  def create
    @cliente = Cliente.new(cliente_params)
    @cliente.marketing_tipos << params[:marketing_tipos] #rever

    if @cliente.save
      respond_to do |format|
        format.js { render file: "ajax/clientes/mostra_novo_cliente.js.erb" }
      end
    else
      renderiza_crud_js(@cliente)
    end
  end

  def update
    if @cliente.update(cliente_params)
      renderiza_crud_js(@cliente, 'Cliente alterado com sucesso.')
    else
      renderiza_crud_js(@cliente)
    end
  end

  def destroy
    @cliente.destroy
    # renderiza_crud_js(@cliente, 'Cliente excluído com sucesso.')
    respond_to do |format|
      format.js { render file: "ajax/clientes/mostra_pesquisa.js.erb" }
    end
  end

  private

    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def cliente_params
      params.require(:cliente).permit(:nome, :apelido, :ficticio, :sexo, :data_nascimento, :inscricao_estadual, :cpf_cnpj, :rg,
                                      :rg_emissor, :rg_data_emissao, :pessoa_tipo, :cadastro_tipo, :obsevacao,
                                      :marketing_tipos => [])
    end

end
