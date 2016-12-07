class ClienteDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def_delegators :@view, :link_to, :edit_cliente_path

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
      [
        "ativo",
        record.cadastro_tipo,
        record.cpf_cnpj,
        record.nome,
        record.apelido,
        record.ficticio,
        "cidade",
        "uf",
      ]
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
