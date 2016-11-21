class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def mostra_modal(obj, model = params[:controller].singularize)
    respond_to do |format|
      format.js { render file: "ajax/application/mostra_modal.js.erb", locals: {obj: obj, model: model} }
    end
  end

  def renderiza_crud_js(obj, mensagem = '', acao = action_name, controller = params[:controller])
    respond_to do |format|
      format.js { render file: 'ajax/application/crud.js.erb', locals: { notice: mensagem, obj: obj, acao: acao, controller: controller } }
    end
  end

end
