class CepsController < ApplicationController
  def buscar
    @logradouro = Logradouro.find_by_cep(params[:cep])
    if @logradouro
      respond_to do |format|
        format.js { render file: "ajax/ceps/busca_cep.js.erb", locals: { model: params[:controller].singularize } }
      end
    end
  end

  private
    def cliente_params
      params.require(:cep).permit(:cep)
    end
end
