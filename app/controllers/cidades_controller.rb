class CidadesController < ApplicationController
  before_action :set_cidade, only: [:edit, :update, :destroy]

  def index
    @cidades = Cidade.all
  end

  def new
    @cidade = Cidade.new
  end

  def edit
  end

  def create
    @cidade = Cidade.new(cidade_params)
    respond_to do |format|
      if @cidade.save
        format.html { redirect_to cidades_path, notice: 'Cidade foi criada com sucesso' }
        # format.json { render :show, status: :created, location: @cidade }
      else
        format.html { render :new, notice: 'Erro ao criar nova Cidade' }
        # format.json { render json: @cidade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cidade.update(cidade_params)
        format.html { redirect_to cidades_path, notice: 'Cidade foi alterada com sucesso.' }
        # format.json { render :show, status: :ok, location: @cidade }
      else
        format.html { render :edit }
        # format.json { render json: @cidade.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cidade.destroy
    respond_to do |format|
      format.html { redirect_to cidades_url, notice: 'Cidade foi excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_cidade
      @cidade = Cidade.find(params[:id])
    end

    def cidade_params
      params.require(:cidade).permit(:nome, :estado_id)
    end
end
