class ClienteDatatable < AjaxDatatablesRails::Base
  include ApplicationHelper

  def view_columns
    @view_columns ||= {
      ativo: { source: "Cliente.ativo", cond: :like },
      cadastro_tipo: { source: "Cliente.cadastro_tipo", cond: filtra_cadastro_tipo },
      cpf_cnpj: { source: "Cliente.cpf_cnpj", cond: :like },
      nome: { source: "Cliente.nome", cond: :like },
      apelido: { source: "Cliente.apelido", cond: :like },
      ficticio: { source: "Cliente.ficticio", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_sigla: { source: "Estado.sigla", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        ativo: material_check_box(record.ativo),
        cadastro_tipo: record.cadastro_tipo,
        cpf_cnpj: record.cpf_cnpj,
        nome: record.nome,
        apelido: record.apelido,
        ficticio: record.ficticio,
        cidade_nome: record.cidade_nome,
        estado_sigla: record.estado_sigla,
        DT_RowId: "cliente_#{record.id}",
      }
    end
  end

  def get_raw_records
    Cliente.left_outer_joins(enderecos: { cidade: :estado })
      .where("enderecos.primario = true or enderecos.primario is null")
      .select("clientes.*, cidades.nome as 'cidade_nome', estados.sigla as 'estado_sigla'")
  end

  def filtra_cadastro_tipo
    ->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ Cliente.cadastro_tipos[column.search.value] }") }
  end

  def permitido?
    options[:permitido]
  end
end
