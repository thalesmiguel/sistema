class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def mostra_modal(model: params[:controller].singularize, caminho: 'form')
    respond_to do |format|
      format.js { render file: "ajax/application/mostra_modal.js.erb", locals: { model: model, caminho: caminho } }
    end
  end

  def renderiza_crud_js(obj, mensagem = '', model = params[:controller].singularize)
    respond_to do |format|
      format.js { render file: 'ajax/application/crud.js.erb', locals: { notice: mensagem, obj: obj, model: model } }
    end
  end

  def renderiza_erro_controller_js(obj, mensagem = '', model = params[:controller].singularize)
    respond_to do |format|
      format.js { render file: 'ajax/application/erro_controller.js.erb', locals: { notice: mensagem, obj: obj, model: model } }
    end
  end

  # Usado nos Data Tables
  def renderiza_datatable(classe = params[:controller].camelize.singularize)
    render json: "#{classe}Datatable".constantize.new(view_context, { permitido: permitido? })
  end

  def permitido?
    ability = Ability.new(current_user)
    ability.can? :manage, params[:controller].singularize
  end


  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :admin, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
