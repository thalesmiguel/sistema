class FazendaDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Fazenda.nome', 'Fazenda.cidade', 'Fazenda.estado', 'Fazenda.inscricao_estadual', 'Fazenda.cnpj',
                           'Fazenda.cnpj_produtor', 'Fazenda.ativa', 'Fazenda.vendas', 'Fazenda.compras']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Fazenda.nome', 'Fazenda.cidade', 'Fazenda.estado', 'Fazenda.inscricao_estadual', 'Fazenda.cnpj',
                             'Fazenda.cnpj_produtor', 'Fazenda.ativa', 'Fazenda.vendas', 'Fazenda.compras']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.nome,
        '1': record.cidade.nome,
        '2': record.cidade.estado.sigla,
        '3': record.inscricao_estadual,
        '4': record.cnpj_fazenda,
        '5': record.cnpj_produtor,
        '6': material_check_box(record.ativo),
        '7': 0,
        '8': 0,

        'DT_RowId' => "fazenda_#{record.id}",
      }
    end
  end

  def get_raw_records
    # Fazenda.all
    options[:fazendas]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
