class ClienteDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Cliente.cadastro_tipo', 'Cliente.cpf_cnpj', 'Cliente.nome', 'Cliente.apelido', 'Cliente.ficticio']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Cliente.nome']
  end


  private

  def data
    records.map do |record|
      {
        '0': material_check_box(record.ativo),
        '1': record.cadastro_tipo,
        '2': record.cpf_cnpj,
        '3': record.nome,
        '4': record.apelido,
        '5': record.ficticio,
        '6': record.cidade_primaria("nome"),
        '7': record.estado_primario("sigla"),

        'DT_RowId' => "cliente_#{record.id}",
      }
    end
  end

  def get_raw_records
    Cliente.all
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
