class EnderecoDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view, :link_to, :edit_cliente_endereco_path, :cliente_endereco_path

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
      [
        record.tipo,
        record.logradouro,
        record.numero,
        record.complemento,
        record.bairro,
        record.cep,
        record.caixa_postal,
        "record.cidade",
        "record.cidade",
        record.ativo,
        record.primario,
        "#{link_to_edit edit_cliente_endereco_path(record.cliente, record) if permitido?}" "#{link_to_destroy cliente_endereco_path(record.cliente, record), 'excluir-endereco' if permitido?}"
      ]
    end
  end

  def get_raw_records
    Endereco.all
  end

  def permitido?
    options[:permitido]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
