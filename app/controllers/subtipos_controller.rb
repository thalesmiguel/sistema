class SubtiposController < ApplicationController
  before_action :set_subtipo, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { renderiza_datatable }
    end
  end

  def new
    @subtipo = Subtipo.new
    mostra_modal
  end

  def edit
    mostra_modal
  end

  def create
    @subtipo = Subtipo.new(subtipo_params)
    if @subtipo.save
      renderiza_crud_js(@subtipo, 'Subtipo criado com sucesso.')
    else
      renderiza_crud_js(@subtipo)
    end
  end

  def update
    if @subtipo.update(subtipo_params)
      renderiza_crud_js(@subtipo, 'Subtipo alterado com sucesso.')
    else
      renderiza_crud_js(@subtipo)
    end
  end

  def destroy
    @subtipo.destroy
    renderiza_crud_js(@subtipo, 'Subtipo excluído com sucesso.')
  end

  private

    def set_subtipo
      @subtipo = Subtipo.find(params[:id])
    end

    def subtipo_params
      params.require(:subtipo).permit(:nome)
    end

end
