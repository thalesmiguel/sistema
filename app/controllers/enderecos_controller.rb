class EnderecosController < ApplicationController
  before_action :set_endereco, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_endereco = params[:cliente_id]
    @enderecos = Endereco.where(cliente_id: @cliente_endereco)
    respond_to do |format|
      format.json { render json: EnderecoDatatable.new(view_context, { cliente: @cliente_endereco, permitido: permitido? }) }
      format.js { mostra_enderecos(@enderecos) }
    end
  end

  def new
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @estados.first)

    @cliente = Cliente.find(params[:cliente_id])
    @endereco = @cliente.enderecos.build
    # @endereco = Endereco.new(cliente: @cliente)
    mostra_modal(caminho: "clientes/enderecos/form")
  end

  def edit
    @estados = Estado.all
    @cidades = Cidade.where("estado_id = ?", @endereco.cidade.estado_id)

    mostra_modal(caminho: "clientes/enderecos/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @endereco = @cliente.enderecos.new(endereco_params)
    # @endereco = Endereco.new(endereco_params)
    if @endereco.save
      renderiza_crud_js(@endereco, 'Endereço criado com sucesso.')
    else
      renderiza_crud_js(@endereco)
    end
  end

  def update
    if @endereco.update(endereco_params)
      renderiza_crud_js(@endereco, 'Endereço alterado com sucesso.')
    else
      renderiza_crud_js(@endereco)
    end
  end

  def destroy
    @endereco.destroy
    renderiza_crud_js(@endereco, 'Endereço excluído com sucesso.')
  end

  private

    def mostra_enderecos(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/enderecos/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_endereco
      @endereco = Endereco.find(params[:id])
      @cliente = @endereco.cliente
    end

    def endereco_params
      params.require(:endereco).permit(:tipo, :logradouro, :numero, :complemento, :caixa_postal, :bairro, :pais,
                                       :cep, :aos_cuidados, :primario, :ativo, :cliente_id, :cidade_id)
    end

end
