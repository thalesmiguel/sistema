class ClienteBancoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['ClienteBanco.agencia', 'ClienteBanco.conta_corrente', 'ClienteBanco.data_abertura_conta',
                           'ClienteBanco.observacao', 'ClienteBanco.correntista_nome', 'ClienteBanco.correntista_cpf_cnpj', 'ClienteBanco.primario', 'ClienteBanco.ativo']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['ClienteBanco.agencia', 'ClienteBanco.conta_corrente', 'ClienteBanco.data_abertura_conta',
                             'ClienteBanco.observacao', 'ClienteBanco.correntista_nome', 'ClienteBanco.correntista_cpf_cnpj', 'ClienteBanco.primario', 'ClienteBanco.ativo']
  end


  private

  def data
    records.map do |record|
      {
        '0': record.banco.codigo,
        '1': record.banco.nome,
        '2': record.agencia,
        '3': record.conta_corrente,
        '4': record.cidade.nome,
        '5': record.cidade.estado.sigla,
        '6': record.correntista_nome,
        '7': record.correntista_cpf_cnpj,
        '8': record.observacao,
        '9': record.created_at.to_s(:data_formatada),
        '10': material_check_box(record.primario),
        '11': material_check_box(record.ativo),

        'DT_RowId' => "cliente_banco_#{record.id}",
      }
    end
  end

  def get_raw_records
    # ClienteBanco.all
    options[:cliente_bancos]
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
