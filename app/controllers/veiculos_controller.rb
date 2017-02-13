class VeiculosController < ApplicationController
  before_action :set_veiculo, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @veiculo = Veiculo.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @veiculo = Veiculo.new(veiculo_params)
    if @veiculo.save
      renderiza_crud_js(@veiculo, 'Veículo criado com sucesso.')
    else
      renderiza_crud_js(@veiculo)
    end
  end

  def update
    if @veiculo.update(veiculo_params)
      renderiza_crud_js(@veiculo, 'Veículo alterado com sucesso.')
    else
      renderiza_crud_js(@veiculo)
    end
  end

  def destroy
    @veiculo.destroy
    renderiza_crud_js(@veiculo, 'Veículo excluído com sucesso.')
  end

  private

    def set_veiculo
      @veiculo = Veiculo.find(params[:id])
    end

    def veiculo_params
      params.require(:veiculo).permit(:disponivel_viagem, :modelo, :ano, :chassi, :placa, :renavam,
                                      :motor, :data_compra, :nf, :ocupantes, :media, :combustivel)
    end

end
