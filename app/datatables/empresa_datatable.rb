class EmpresaDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      nome: { source: "Empresa.nome", cond: :like },
      cnpj: { source: "Empresa.cnpj", cond: :like },
      cargo: { source: "Empresa.cargo", cond: :like },
      logradouro: { source: "Empresa.logradouro", cond: :like },
      cidade_nome: { source: "Cidade.nome", cond: :like },
      estado_nome: { source: "Estado.sigla", cond: :like },
      cep: { source: "Empresa.cep", cond: :like },
    }
  end

  private

  def data
    records.map do |record|
      {
        nome: record.nome,
        cnpj: record.cnpj,
        cargo: record.cargo,
        logradouro: record.logradouro,
        cidade_nome: record.cidade.nome,
        estado_nome: record.cidade.estado.sigla,
        cep: record.cep,
        DT_RowId: "empresa_#{record.id}",
      }
    end
  end

  def get_raw_records
    Empresa.joins(cidade: :estado).where(cliente_id: options[:cliente])
  end

  def permitido?
    options[:permitido]
  end
end
