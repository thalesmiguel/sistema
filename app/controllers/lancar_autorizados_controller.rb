class LancarAutorizadosController < ApplicationController
  before_action :set_lancar_autorizado, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_lancar_autorizado = params[:cliente_id]
    @lancar_autorizados = LancarAutorizado.where(cliente_id: params[:cliente_id])
    respond_to do |format|
      format.json { render json: LancarAutorizadoDatatable.new(view_context, { lancar_autorizados: @lancar_autorizados, permitido: permitido? }) }
      format.js { mostra_lancar_autorizados(@lancar_autorizados) }
    end
  end

  def new
    @cliente = Cliente.find(params[:cliente_id])
    @lancar_autorizado = @cliente.lancar_autorizados.build
    mostra_modal(caminho: "clientes/lancar_autorizados/form")
  end

  def edit
    mostra_modal(caminho: "clientes/lancar_autorizados/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @lancar_autorizado = @cliente.lancar_autorizados.new(lancar_autorizado_params)
    if @lancar_autorizado.save
      renderiza_crud_js(@lancar_autorizado, 'Autorizado a Lançar criado com sucesso.')
    else
      renderiza_crud_js(@lancar_autorizado)
    end
  end

  def update
    if @lancar_autorizado.update(lancar_autorizado_params)
      renderiza_crud_js(@lancar_autorizado, 'Autorizado a Lançar alterado com sucesso.')
    else
      renderiza_crud_js(@lancar_autorizado)
    end
  end

  def destroy
    @lancar_autorizado.destroy
    renderiza_crud_js(@lancar_autorizado, 'Autorizado a Lançar excluído com sucesso.')
  end

  def deleta_procuracao
    @deleta_procuracao_lancar_autorizado = LancarAutorizado.find_by_id(params[:id])
    @deleta_procuracao_lancar_autorizado.procuracao = nil
    if @deleta_procuracao_lancar_autorizado.save
      renderiza_crud_js(@deleta_procuracao_lancar_autorizado, 'Procuração excluída com sucesso.')
    end
  end

  private

    def mostra_lancar_autorizados(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/lancar_autorizados/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_lancar_autorizado
      @lancar_autorizado = LancarAutorizado.find(params[:id])
      @cliente = @lancar_autorizado.cliente
    end

    def lancar_autorizado_params
      params.require(:lancar_autorizado).permit(:nome, :cpf, :observacao, :tem_procuracao, :ativo, :procuracao, :cliente_id)
    end

end
