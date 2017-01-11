class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_empresa = params[:cliente_id]
    @empresas = Empresa.where(cliente_id: params[:cliente_id])
    respond_to do |format|
      format.json { render json: EmpresaDatatable.new(view_context, { empresas: @empresas, permitido: permitido? }) }
      format.js { mostra_empresas(@empresas) }
    end
  end

  def new
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @estados.first)

    @cliente = Cliente.find(params[:cliente_id])
    @empresa = @cliente.empresas.build
    # @empresa = Empresa.new(cliente: @cliente)
    mostra_modal(caminho: "clientes/empresas/form")
  end

  def edit
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @empresa.cidade.estado_id)

    mostra_modal(caminho: "clientes/empresas/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @empresa = @cliente.empresas.new(empresa_params)
    # @empresa = Empresa.new(empresa_params)
    if @empresa.save
      renderiza_crud_js(@empresa, 'Empresa criada com sucesso.')
    else
      renderiza_crud_js(@empresa)
    end
  end

  def update
    if @empresa.update(empresa_params)
      renderiza_crud_js(@empresa, 'Empresa alterada com sucesso.')
    else
      renderiza_crud_js(@empresa)
    end
  end

  def destroy
    @empresa.destroy
    renderiza_crud_js(@empresa, 'Empresa excluída com sucesso.')
  end

  private

    def mostra_empresas(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/empresas/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_empresa
      @empresa = Empresa.find(params[:id])
      @cliente = @empresa.cliente
    end

    def empresa_params
      params.require(:empresa).permit(:nome, :cnpj, :cargo, :logradouro, :numero, :complemento, :bairro, :cidade_id,
                                      :cep, :caixa_postal, :cliente_id)
    end

end
