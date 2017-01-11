class ClienteDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Cliente.cadastro_tipo', 'Cliente.cpf_cnpj', 'Cliente.nome', 'Cliente.apelido', 'Cliente.ficticio']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Cliente.nome', 'Cliente.apelido', 'Cliente.ficticio',  'Cliente.cpf_cnpj', 'Cidade.nome', 'Estado.sigla']
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
        '6': record.cidade_nome,
        '7': record.estado_sigla,

        'DT_RowId': "cliente_#{record.id}",
        # 'DT_RowClass': "bozo",
      }
    end
  end

  def get_raw_records
    Cliente.left_outer_joins(enderecos: { cidade: :estado })
      .where("enderecos.primario = true or enderecos.primario is null")
      .select("clientes.*, cidades.nome as 'cidade_nome', estados.sigla as 'estado_sigla'")
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
