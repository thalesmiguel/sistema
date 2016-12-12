class EnderecoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Endereco.tipo', 'Endereco.logradouro', 'Endereco.numero', 'Endereco.complemento', 'Endereco.bairro',
                           'Endereco.cep', 'Endereco.caixa_postal', 'Endereco.ativo', 'Endereco.primario']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Endereco.tipo', 'Endereco.logradouro', 'Endereco.numero', 'Endereco.complemento', 'Endereco.bairro',
                             'Endereco.cep', 'Endereco.caixa_postal', 'Endereco.ativo', 'Endereco.primario']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.tipo,
        '1': record.logradouro,
        '2': record.numero,
        '3': record.complemento,
        '4': record.bairro,
        '5': record.cep,
        '6': record.caixa_postal,
        '7': record.cidade.nome,
        '8': record.cidade.estado.sigla,
        '9': material_check_box(record.ativo),
        '10': material_check_box(record.primario),

        'DT_RowId' => "endereco_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Endereco.all
    options[:enderecos]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
