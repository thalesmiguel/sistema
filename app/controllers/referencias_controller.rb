class ReferenciasController < ApplicationController
  before_action :set_referencia, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_referencia = params[:cliente_id]
    @referencias = Referencia.where(cliente_id: params[:cliente_id])
    respond_to do |format|
      format.json { render json: ReferenciaDatatable.new(view_context, { referencias: @referencias, permitido: permitido? }) }
      format.js { mostra_referencias(@referencias) }
    end
  end

  def new
    @cliente = Cliente.find(params[:cliente_id])
    @referencia = @cliente.referencias.build
    mostra_modal(caminho: "clientes/referencias/form")
  end

  def edit
    mostra_modal(caminho: "clientes/referencias/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @referencia = @cliente.referencias.new(referencia_params)
    if @referencia.save
      renderiza_crud_js(@referencia, 'Referência criada com sucesso.')
    else
      renderiza_crud_js(@referencia)
    end
  end

  def update
    if @referencia.update(referencia_params)
      renderiza_crud_js(@referencia, 'Referência alterada com sucesso.')
    else
      renderiza_crud_js(@referencia)
    end
  end

  def destroy
    @referencia.destroy
    renderiza_crud_js(@referencia, 'Referência excluída com sucesso.')
  end

  private

    def mostra_referencias(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/referencias/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_referencia
      @referencia = Referencia.find(params[:id])
      @cliente = @referencia.cliente
    end

    def referencia_params
      params.require(:referencia).permit(:nome, :telefone, :observacao, :cliente_id)
    end

end
