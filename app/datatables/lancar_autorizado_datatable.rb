class LancarAutorizadoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['LancarAutorizado.nome', 'LancarAutorizado.cpf', 'LancarAutorizado.tem_procuracao', 'LancarAutorizado.ativo', 'LancarAutorizado.observacao']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['LancarAutorizado.nome', 'LancarAutorizado.cpf', 'LancarAutorizado.tem_procuracao', 'LancarAutorizado.ativo', 'LancarAutorizado.observacao']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.nome,
        '1': record.cpf,
        '2': material_check_box(record.tem_procuracao),
        '3': record.observacao,
        '4': material_check_box(record.ativo),

        'DT_RowId' => "lancar_autorizado_#{record.id}",
      }
    end
  end

  def get_raw_records
    # LancarAutorizado.all
    options[:lancar_autorizados]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
