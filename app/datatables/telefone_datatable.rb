class TelefoneDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Telefone.tipo', 'Telefone.ddi', 'Telefone.ddd', 'Telefone.numero', 'Telefone.created_at', 'Telefone.ramal',
                           'Telefone.nome_contato', 'Telefone.importancia', 'Telefone.telemarketing', 'Telefone.divulgar', 'Telefone.ativo']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Telefone.tipo', 'Telefone.ddi', 'Telefone.ddd', 'Telefone.numero', 'Telefone.created_at', 'Telefone.ramal',
                             'Telefone.nome_contato', 'Telefone.importancia', 'Telefone.telemarketing', 'Telefone.divulgar', 'Telefone.ativo']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.tipo,
        '1': record.ddi,
        '2': record.ddd,
        '3': record.numero,
        '4': record.created_at.to_s(:data_formatada),
        '5': record.ramal,
        '6': record.nome_contato,
        '7': record.importancia,
        '8': material_check_box(record.telemarketing),
        '9': material_check_box(record.divulgar),
        '10': material_check_box(record.ativo),

        'DT_RowId' => "telefone_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Telefone.all
    options[:telefones]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
