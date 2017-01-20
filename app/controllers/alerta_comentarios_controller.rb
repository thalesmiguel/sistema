class AlertaComentariosController < ApplicationController
  before_action :set_alerta_comentario, only: [:edit, :update, :destroy, :altera_status]

  def index
    @alerta_alerta_comentario = params[:alerta_id]
    @alerta_comentarios = AlertaComentario.where(alerta_id: @alerta_alerta_comentario)
    respond_to do |format|
      format.json { render json: AlertaComentarioDatatable.new(view_context, { alerta: @alerta_alerta_comentario, permitido: permitido? }) }
      format.js { mostra_alerta_comentarios(@alerta_comentarios) }
    end
  end

  def new
    @alerta = Alerta.find(params[:alerta_id])
    @alerta_comentario = @alerta.alerta_comentarios.build
    mostra_modal(caminho: "clientes/alertas/alerta_comentarios/form")
  end

  def edit
    mostra_modal(caminho: "clientes/alertas/alerta_comentarios/form")
  end

  def create
    @alerta = Alerta.find(params[:alerta_id])

    @alerta_comentario = @alerta.alerta_comentarios.new(alerta_comentario_params)
    if @alerta_comentario.save
      renderiza_crud_js(@alerta, 'Comentário criado com sucesso.')
    else
      renderiza_crud_js(@alerta_comentario)
    end
  end

  def update
    if @alerta_comentario.update(alerta_comentario_params)
      renderiza_crud_js(@alerta_comentario, 'Comentário alterado com sucesso.')
    else
      renderiza_crud_js(@alerta_comentario)
    end
  end

  def destroy
    @alerta_comentario.destroy
    renderiza_crud_js(@alerta_comentario, 'Comentário excluído com sucesso.')
  end

  private

    def mostra_alerta_comentarios(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/alertas/alerta_comentarios/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_alerta_comentario
      @alerta_comentario = AlertaComentario.find(params[:id])
      @alerta = @alerta_comentario.alerta
    end

    def alerta_comentario_params
      params.require(:alerta_comentario).permit(:descricao, :alerta_id)
    end

end
