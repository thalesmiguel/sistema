class EmailsController < ApplicationController
  before_action :set_email, only: [:edit, :update, :destroy, :altera_status]

  def index
    @cliente_email = params[:cliente_id]
    @emails = Email.where(cliente_id: @cliente_email)
    respond_to do |format|
      format.json { render json: EmailDatatable.new(view_context, { cliente: @cliente_email, permitido: permitido? }) }
      format.js { mostra_emails(@emails) }
    end
  end

  def new
    @cliente = Cliente.find(params[:cliente_id])
    @email = @cliente.emails.build
    mostra_modal(caminho: "clientes/emails/form")
  end

  def edit
    mostra_modal(caminho: "clientes/emails/form")
  end

  def create
    @cliente = Cliente.find(params[:cliente_id])

    @email = @cliente.emails.new(email_params)
    if @email.save
      renderiza_crud_js(@email, 'Email criado com sucesso')
    else
      renderiza_crud_js(@email)
    end
  end

  def update
    if @email.update(email_params)
      renderiza_crud_js(@email, 'Email alterado com sucesso')
    else
      renderiza_crud_js(@email)
    end
  end

  def destroy
    @email.destroy
    renderiza_crud_js(@email, 'Email excluído com sucesso')
  end

  private

    def mostra_emails(obj, model = params[:controller].singularize)
      render file: "ajax/clientes/emails/index.js.erb", locals: {obj: obj, model: model}
    end

    def set_email
      @email = Email.find(params[:id])
      @cliente = @email.cliente
    end

    def email_params
      params.require(:email).permit(:email, :contato, :mala_direta, :solicitacao_email, :envio_contratos, :ativo, :cliente_id)
    end

end
