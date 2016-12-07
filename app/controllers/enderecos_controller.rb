class EnderecosController < ApplicationController
  before_action :set_endereco, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: EnderecoDatatable.new(view_context, { permitido: permitido? }) }
    end
  end

  def new
    @endereco = Endereco.new
    mostra_modal(@endereco)
  end

  def edit
    mostra_modal(@endereco)
  end

  def create
    @endereco = Endereco.new(endereco_params)
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

    def set_endereco
      @endereco = Endereco.find(params[:id])
    end

    def endereco_params
      params.require(:endereco).permit(:tipo, :logradouro, :numero, :complemento, :caixa_postal, :bairro, :pais, :cep, :aos_cuidados, :primario, :ativo)
    end

end
