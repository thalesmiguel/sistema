class TelefonesController < ApplicationController
  before_action :set_telefone, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_telefone = params[:cliente_id]
    @telefones = Telefone.where(cliente_id: @cliente_telefone)
    respond_to do |format|
      format.json { render json: TelefoneDatatable.new(view_context, { cliente: @cliente_telefone, permitido: permitido? }) }
      format.js { mostra_telefones(@telefones) }
    end
  end

  def new
    @cliente = Cliente.find(params[:cliente_id])
    @telefone = @cliente.telefones.build
    mostra_modal(caminho: "clientes/telefones/form")
  end

  def edit
    mostra_modal(caminho: "clientes/telefones/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @telefone = @cliente.telefones.new(telefone_params)
    if @telefone.save
      renderiza_crud_js(@telefone, 'Telefone criado com sucesso')
    else
      renderiza_crud_js(@telefone)
    end
  end

  def update
    if @telefone.update(telefone_params)
      renderiza_crud_js(@telefone, 'Telefone alterado com sucesso')
    else
      renderiza_crud_js(@telefone)
    end
  end

  def destroy
    @telefone.destroy
    renderiza_crud_js(@telefone, 'Telefone excluído com sucesso')
  end

  private

    def mostra_telefones(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/telefones/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_telefone
      @telefone = Telefone.find(params[:id])
      @cliente = @telefone.cliente
    end

    def telefone_params
      params.require(:telefone).permit(:tipo, :ddi, :ddd, :numero, :ramal, :nome_contato, :importancia, :telemarketing, :divulgar, :ativo, :cliente_id)
    end

end
