class EstadosController < ApplicationController
  before_action :set_estado, only: [:edit, :update, :destroy]

  def index
    @estados = Estado.all
  end

  def new
    @estado = Estado.new
  end

  def edit
  end

  def create
    @estado = Estado.new(estado_params)

    respond_to do |format|
      if @estado.save
        format.html { redirect_to estados_path, notice: 'Estado foi criado com sucesso' }
        # format.json { render :show, status: :created, location: @estado }
      else
        format.html { render :new, notice: 'Erro ao criar novo Estado' }
        # format.json { render json: @estado.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @estado.update(estado_params)
        format.html { redirect_to estados_path, notice: 'Estado foi criado com sucesso' }
        format.json { render :show, status: :ok, location: @estado }
      else
        format.html { render :edit }
        format.json { render json: @estado.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @estado.destroy
    respond_to do |format|
      format.html { redirect_to estados_url, notice: 'Estado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_estado
      @estado = Estado.find(params[:id])
    end

    def estado_params
      params.require(:estado).permit(:nome, :sigla)
    end
end
