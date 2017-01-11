class EmpresaDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Empresa.nome', 'Empresa.cnpj', 'Empresa.cargo', 'Empresa.logradouro', 'Empresa.cep']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Empresa.nome', 'Empresa.cnpj', 'Empresa.cargo', 'Empresa.logradouro', 'Empresa.cep']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.nome,
        '1': record.cnpj,
        '2': record.cargo,
        '3': record.logradouro,
        '4': record.cidade.nome,
        '5': record.cidade.estado.sigla,
        '6': record.cep,

        'DT_RowId' => "empresa_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Empresa.all
    options[:empresas]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
