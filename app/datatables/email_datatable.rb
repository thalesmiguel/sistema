class EmailDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      email: { source: "Email.email", cond: :like },
      contato: { source: "Email.contato", cond: :like },
      created_at: { source: "Email.created_at", cond: :like },
      mala_direta: { source: "Email.mala_direta", cond: :like },
      ativo: { source: "Email.ativo", cond: :like },
      solicitacao_email: { source: "Email.solicitacao_email", cond: :like },
      envio_contratos: { source: "Email.envio_contratos", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        email: record.email,
        contato: record.contato,
        created_at: record.created_at.to_s(:data_formatada),
        mala_direta: material_check_box(record.mala_direta),
        ativo: material_check_box(record.ativo),
        solicitacao_email: material_check_box(record.solicitacao_email),
        envio_contratos: material_check_box(record.envio_contratos),
        DT_RowId: "email_#{record.id}",
      }
    end
  end

  def get_raw_records
    Email.where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
