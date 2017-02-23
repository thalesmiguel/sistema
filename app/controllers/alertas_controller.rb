class AlertasController < ApplicationController
  before_action :set_alerta, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_alerta = params[:cliente_id]
    @alertas = Alerta.where(cliente_id: @cliente_alerta).order(:created_at)

    if !params[:somente_ativos]
      params[:somente_ativos] = "false"
    end

    respond_to do |format|
      format.json {
        render json: AlertaDatatable.new(view_context, { cliente: @cliente_alerta, permitido: permitido?, somente_ativos: params[:somente_ativos] }) }
      format.js { mostra_alertas(@alertas) }
    end
  end

  def new
    @cliente = Cliente.find(params[:cliente_id])
    @alerta = @cliente.alertas.build
    mostra_modal(caminho: "clientes/alertas/form")
  end

  def edit
    mostra_modal(caminho: "clientes/alertas/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])
    @alerta = @cliente.alertas.new(alerta_params)

    if @alerta.save
      renderiza_crud_js(@alerta, 'Alerta criado com sucesso')
    else
      renderiza_crud_js(@alerta)
    end
  end

  def update
    if @alerta.update(alerta_params)
      renderiza_crud_js(@alerta, 'Alerta alterado com sucesso')
    else
      renderiza_crud_js(@alerta)
    end
  end

  def destroy
    @alerta.destroy
    renderiza_crud_js(@alerta, 'Alerta excluído com sucesso')
  end

  private

    def mostra_alertas(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/alertas/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_alerta
      @alerta = Alerta.find(params[:id])
      @cliente = @alerta.cliente
    end

    def alerta_params
      params.require(:alerta).permit(:tipo, :descricao, :ativo, :cliente_id, :user_id)
    end

end
