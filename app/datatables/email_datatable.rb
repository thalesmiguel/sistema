class EmailDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Email.email', 'Email.contato', 'Email.mala_direta', 'Email.solicitacao_email', 'Email.envio_contratos', 'Email.ativo']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Email.email', 'Email.contato', 'Email.mala_direta', 'Email.solicitacao_email', 'Email.envio_contratos', 'Email.ativo']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.email,
        '1': record.contato,
        '2': record.created_at.to_s(:data_formatada),
        '3': material_check_box(record.mala_direta),
        '4': material_check_box(record.ativo),
        '5': material_check_box(record.solicitacao_email),
        '6': material_check_box(record.envio_contratos),

        'DT_RowId' => "email_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Email.all
    options[:emails]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
