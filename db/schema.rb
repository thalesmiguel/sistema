# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170313123937) do

  create_table "alerta_comentarios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "descricao",  limit: 65535
    t.integer  "alerta_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["alerta_id"], name: "index_alerta_comentarios_on_alerta_id", using: :btree
  end

  create_table "alertas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.text     "descricao",  limit: 65535
    t.boolean  "ativo",                    default: true
    t.integer  "cliente_id"
    t.integer  "user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["cliente_id"], name: "index_alertas_on_cliente_id", using: :btree
    t.index ["user_id"], name: "index_alertas_on_user_id", using: :btree
  end

  create_table "assessorias", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.text     "observacao",        limit: 65535
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes", limit: 65535
    t.integer  "version",                       default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "bairros", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "cidade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cidade_id"], name: "index_bairros_on_cidade_id", using: :btree
  end

  create_table "bancos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "codigo"
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bandeiras", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "sigla"
    t.string   "cor"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "canais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.text     "observacao",        limit: 65535
    t.text     "inf_transmissao",   limit: 65535
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "cidades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id", using: :btree
  end

  create_table "cliente_bancos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "banco_id"
    t.string   "agencia"
    t.string   "conta_corrente"
    t.integer  "cidade_id"
    t.date     "data_abertura_conta"
    t.text     "observacao",           limit: 65535
    t.string   "correntista_nome"
    t.string   "correntista_cpf_cnpj"
    t.boolean  "primario",                           default: true
    t.boolean  "ativo",                              default: true
    t.integer  "cliente_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["banco_id"], name: "index_cliente_bancos_on_banco_id", using: :btree
    t.index ["cidade_id"], name: "index_cliente_bancos_on_cidade_id", using: :btree
    t.index ["cliente_id"], name: "index_cliente_bancos_on_cliente_id", using: :btree
  end

  create_table "clientes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "apelido"
    t.string   "ficticio"
    t.integer  "sexo"
    t.date     "data_nascimento"
    t.string   "inscricao_estadual"
    t.string   "cpf_cnpj"
    t.string   "rg"
    t.string   "rg_emissor"
    t.date     "rg_data_emissao"
    t.integer  "pessoa_tipo"
    t.integer  "cadastro_tipo"
    t.text     "marketing_tipos",    limit: 65535
    t.text     "observacao",         limit: 65535
    t.boolean  "ativo",                            default: true
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "contato"
    t.boolean  "mala_direta",       default: true
    t.boolean  "solicitacao_email", default: true
    t.boolean  "envio_contratos",   default: true
    t.boolean  "ativo",             default: true
    t.integer  "cliente_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["cliente_id"], name: "index_emails_on_cliente_id", using: :btree
  end

  create_table "empresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "cnpj"
    t.string   "cargo"
    t.string   "logradouro"
    t.string   "numero"
    t.string   "complemento"
    t.string   "bairro"
    t.integer  "cidade_id"
    t.string   "cep"
    t.string   "caixa_postal"
    t.integer  "cliente_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["cidade_id"], name: "index_empresas_on_cidade_id", using: :btree
    t.index ["cliente_id"], name: "index_empresas_on_cliente_id", using: :btree
  end

  create_table "enderecos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.string   "logradouro"
    t.string   "numero"
    t.string   "complemento"
    t.string   "caixa_postal"
    t.string   "bairro"
    t.integer  "cidade_id"
    t.string   "pais",         default: "Brasil"
    t.string   "cep"
    t.string   "aos_cuidados"
    t.boolean  "primario",     default: true
    t.boolean  "ativo",        default: true
    t.integer  "cliente_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["cidade_id"], name: "index_enderecos_on_cidade_id", using: :btree
    t.index ["cliente_id"], name: "index_enderecos_on_cliente_id", using: :btree
  end

  create_table "estados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fazendas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "cidade_id"
    t.string   "cep"
    t.integer  "tipo"
    t.string   "logradouro"
    t.string   "area"
    t.text     "observacao",         limit: 65535
    t.string   "inscricao_estadual"
    t.string   "cnpj_fazenda"
    t.string   "incra"
    t.string   "cnpj_produtor"
    t.boolean  "faz_terceiro"
    t.string   "nome_nf"
    t.string   "cpf_cnpj_nf"
    t.boolean  "ativo",                            default: true
    t.integer  "cliente_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["cidade_id"], name: "index_fazendas_on_cidade_id", using: :btree
    t.index ["cliente_id"], name: "index_fazendas_on_cliente_id", using: :btree
  end

  create_table "funcoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lancar_autorizados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "cpf"
    t.text     "observacao",              limit: 65535
    t.boolean  "tem_procuracao"
    t.boolean  "ativo",                                 default: true
    t.string   "procuracao_file_name"
    t.string   "procuracao_content_type"
    t.integer  "procuracao_file_size"
    t.datetime "procuracao_updated_at"
    t.integer  "cliente_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["cliente_id"], name: "index_lancar_autorizados_on_cliente_id", using: :btree
  end

  create_table "leilao_assessorias", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "assessoria_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["assessoria_id"], name: "index_leilao_assessorias_on_assessoria_id", using: :btree
    t.index ["leilao_id"], name: "index_leilao_assessorias_on_leilao_id", using: :btree
  end

  create_table "leilao_bandeiras", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "bandeira_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bandeira_id"], name: "index_leilao_bandeiras_on_bandeira_id", using: :btree
    t.index ["leilao_id"], name: "index_leilao_bandeiras_on_leilao_id", using: :btree
  end

  create_table "leilao_canais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "canal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canal_id"], name: "index_leilao_canais_on_canal_id", using: :btree
    t.index ["leilao_id"], name: "index_leilao_canais_on_leilao_id", using: :btree
  end

  create_table "leilao_comissoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.integer  "valor_fixo_venda_centavos",  default: 0,     null: false
    t.string   "valor_fixo_venda_currency",  default: "BRL", null: false
    t.integer  "perc_venda_promotor"
    t.integer  "perc_venda_convidado_elite"
    t.integer  "perc_venda_convidado_corte"
    t.integer  "perc_compra_elite"
    t.integer  "perc_compra_corte"
    t.boolean  "cobra_comissao_retornos"
    t.string   "financ_comissao_compra"
    t.string   "financ_comissao_venda"
    t.string   "financ_solicitacao_entrada"
    t.integer  "leilao_id"
    t.integer  "promotor_banco_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["leilao_id"], name: "index_leilao_comissoes_on_leilao_id", using: :btree
  end

  create_table "leilao_convidados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_leilao_convidados_on_cliente_id", using: :btree
    t.index ["leilao_id"], name: "index_leilao_convidados_on_leilao_id", using: :btree
  end

  create_table "leilao_eventos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "leilao_leiloeiros", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "leiloeiro_id"
    t.decimal  "comissao",     precision: 16, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["leilao_id"], name: "index_leilao_leiloeiros_on_leilao_id", using: :btree
    t.index ["leiloeiro_id"], name: "index_leilao_leiloeiros_on_leiloeiro_id", using: :btree
  end

  create_table "leilao_observacoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "descricao",  limit: 65535
    t.integer  "user_id"
    t.boolean  "ativo",                    default: true
    t.integer  "leilao_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["leilao_id"], name: "index_leilao_observacoes_on_leilao_id", using: :btree
    t.index ["user_id"], name: "index_leilao_observacoes_on_user_id", using: :btree
  end

  create_table "leilao_padroes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pagamento_elite_id"
    t.integer  "pagamento_corte_id"
    t.integer  "pagamento_outros_id"
    t.integer  "dolar_centavos",      default: 0,     null: false
    t.string   "dolar_currency",      default: "BRL", null: false
    t.integer  "arroba_centavos",     default: 0,     null: false
    t.string   "arroba_currency",     default: "BRL", null: false
    t.integer  "leilao_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["leilao_id"], name: "index_leilao_padroes_on_leilao_id", using: :btree
  end

  create_table "leilao_patrocinadores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "patrocinador_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["leilao_id"], name: "index_leilao_patrocinadores_on_leilao_id", using: :btree
    t.index ["patrocinador_id"], name: "index_leilao_patrocinadores_on_patrocinador_id", using: :btree
  end

  create_table "leilao_promotores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_leilao_promotores_on_cliente_id", using: :btree
    t.index ["leilao_id"], name: "index_leilao_promotores_on_leilao_id", using: :btree
  end

  create_table "leilao_racas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "leilao_id"
    t.integer  "raca_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leilao_id"], name: "index_leilao_racas_on_leilao_id", using: :btree
    t.index ["raca_id"], name: "index_leilao_racas_on_raca_id", using: :btree
  end

  create_table "leiloeiros", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome_contrato"
    t.string   "razao_social"
    t.string   "cpf"
    t.string   "cnpj"
    t.string   "sindicato"
    t.string   "logradouro"
    t.integer  "cidade_id"
    t.string   "cep"
    t.string   "email"
    t.string   "telefone"
    t.string   "fax"
    t.string   "sigla"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.decimal  "comissao_elite",    precision: 16, scale: 2, default: "0.0"
    t.decimal  "comissao_virtual",  precision: 16, scale: 2, default: "0.0"
    t.decimal  "comissao_corte",    precision: 16, scale: 2, default: "0.0"
    t.decimal  "comissao_shopping", precision: 16, scale: 2, default: "0.0"
    t.boolean  "comissao_contrato",                          default: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.index ["cidade_id"], name: "index_leiloeiros_on_cidade_id", using: :btree
  end

  create_table "leiloes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "categoria"
    t.integer  "modalidade"
    t.string   "nome"
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.string   "nome_agenda"
    t.string   "nome_site"
    t.integer  "cidade_id"
    t.integer  "tipo"
    t.integer  "situacao"
    t.integer  "testemunha_1_id"
    t.integer  "testemunha_2_id"
    t.integer  "leilao_anterior_id"
    t.integer  "subtipo_lotes_id"
    t.text     "observacao_nota_mapa", limit: 65535
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "leilao_evento_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["cidade_id"], name: "index_leiloes_on_cidade_id", using: :btree
    t.index ["leilao_evento_id"], name: "index_leiloes_on_leilao_evento_id", using: :btree
  end

  create_table "logradouros", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "cep"
    t.string   "complemento"
    t.integer  "bairro_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bairro_id"], name: "index_logradouros_on_bairro_id", using: :btree
  end

  create_table "pagamento_condicoes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "tipo"
    t.integer  "captacoes"
    t.integer  "parcelas"
    t.integer  "frequencia"
    t.boolean  "entrada",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "pagamento_parcelas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "parcela"
    t.integer  "captacoes"
    t.date     "vencimento"
    t.integer  "pagamento_condicao_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["pagamento_condicao_id"], name: "index_pagamento_parcelas_on_pagamento_condicao_id", using: :btree
  end

  create_table "patrocinadores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "planejamento_escalas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "funcionario_id"
    t.integer  "funcao_id"
    t.integer  "uniforme_id"
    t.integer  "diaria_valor_centavos",  default: 0,     null: false
    t.string   "diaria_valor_currency",  default: "BRL", null: false
    t.string   "diaria_descricao"
    t.integer  "despesa_valor_centavos", default: 0,     null: false
    t.string   "despesa_valor_currency", default: "BRL", null: false
    t.string   "despesa_descricao"
    t.string   "avaliacao"
    t.string   "avaliacao_observacao"
    t.integer  "leilao_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["funcao_id"], name: "index_planejamento_escalas_on_funcao_id", using: :btree
    t.index ["leilao_id"], name: "index_planejamento_escalas_on_leilao_id", using: :btree
    t.index ["uniforme_id"], name: "index_planejamento_escalas_on_uniforme_id", using: :btree
  end

  create_table "planejamento_veiculos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.text     "observacao",  limit: 65535
    t.integer  "leilao_id"
    t.integer  "veiculo_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["leilao_id"], name: "index_planejamento_veiculos_on_leilao_id", using: :btree
    t.index ["veiculo_id"], name: "index_planejamento_veiculos_on_veiculo_id", using: :btree
  end

  create_table "planejamento_viagens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "planejamento_escala_id"
    t.integer  "planejamento_veiculo_id"
    t.boolean  "ida"
    t.boolean  "volta"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["planejamento_escala_id"], name: "index_planejamento_viagens_on_planejamento_escala_id", using: :btree
    t.index ["planejamento_veiculo_id"], name: "index_planejamento_viagens_on_planejamento_veiculo_id", using: :btree
  end

  create_table "racas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "especie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referencias", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "telefone"
    t.text     "observacao", limit: 65535
    t.integer  "cliente_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["cliente_id"], name: "index_referencias_on_cliente_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "subtipos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "codigo"
    t.string   "nome"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_tags_on_cliente_id", using: :btree
  end

  create_table "taxa_automaticas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.string   "nome"
    t.string   "nome_resumido"
    t.integer  "cobranca_por"
    t.integer  "cobranca_lote_tipo"
    t.text     "cobrado_de",                    limit: 65535
    t.integer  "lote_a_cada"
    t.integer  "lote_valor_centavos",                         default: 0,      null: false
    t.string   "lote_valor_currency",                         default: "BRTX", null: false
    t.integer  "macho_a_cada"
    t.integer  "macho_intervalo_inicio"
    t.integer  "macho_intervalo_fim"
    t.integer  "macho_valor_centavos",                        default: 0,      null: false
    t.string   "macho_valor_currency",                        default: "BRTX", null: false
    t.boolean  "macho_somente_sem_registro"
    t.integer  "femea_a_cada"
    t.integer  "femea_intervalo_inicio"
    t.integer  "femea_intervalo_fim"
    t.integer  "femea_valor_centavos",                        default: 0,      null: false
    t.string   "femea_valor_currency",                        default: "BRTX", null: false
    t.boolean  "femea_somente_sem_registro"
    t.integer  "sem_sexo_a_cada"
    t.integer  "sem_sexo_intervalo_inicio"
    t.integer  "sem_sexo_intervalo_fim"
    t.integer  "sem_sexo_valor_centavos",                     default: 0,      null: false
    t.string   "sem_sexo_valor_currency",                     default: "BRTX", null: false
    t.boolean  "sem_sexo_somente_sem_registro"
    t.integer  "leilao_id"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.index ["leilao_id"], name: "index_taxa_automaticas_on_leilao_id", using: :btree
  end

  create_table "taxa_manuais", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.string   "nome"
    t.integer  "leilao_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leilao_id"], name: "index_taxa_manuais_on_leilao_id", using: :btree
  end

  create_table "telefones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.string   "ddi",           default: "55"
    t.string   "ddd"
    t.string   "numero"
    t.string   "ramal"
    t.string   "nome_contato"
    t.integer  "importancia"
    t.boolean  "telemarketing", default: true
    t.boolean  "divulgar"
    t.boolean  "ativo",         default: true
    t.integer  "cliente_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["cliente_id"], name: "index_telefones_on_cliente_id", using: :btree
  end

  create_table "uniformes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "sexo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: ""
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "nome",                   default: "", null: false
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "veiculos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "disponivel_viagem",                          default: false
    t.string   "modelo"
    t.integer  "ano"
    t.string   "chassi"
    t.string   "placa"
    t.string   "renavam"
    t.string   "motor"
    t.date     "data_compra"
    t.string   "nf"
    t.integer  "ocupantes"
    t.decimal  "media",             precision: 16, scale: 2
    t.integer  "combustivel"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_foreign_key "alerta_comentarios", "alertas"
  add_foreign_key "alertas", "clientes"
  add_foreign_key "alertas", "users"
  add_foreign_key "bairros", "cidades"
  add_foreign_key "cidades", "estados"
  add_foreign_key "cliente_bancos", "bancos"
  add_foreign_key "cliente_bancos", "cidades"
  add_foreign_key "cliente_bancos", "clientes"
  add_foreign_key "emails", "clientes"
  add_foreign_key "empresas", "cidades"
  add_foreign_key "empresas", "clientes"
  add_foreign_key "enderecos", "cidades"
  add_foreign_key "enderecos", "clientes"
  add_foreign_key "fazendas", "cidades"
  add_foreign_key "fazendas", "clientes"
  add_foreign_key "lancar_autorizados", "clientes"
  add_foreign_key "leilao_assessorias", "assessorias"
  add_foreign_key "leilao_assessorias", "leiloes"
  add_foreign_key "leilao_bandeiras", "bandeiras"
  add_foreign_key "leilao_bandeiras", "leiloes"
  add_foreign_key "leilao_canais", "canais"
  add_foreign_key "leilao_canais", "leiloes"
  add_foreign_key "leilao_comissoes", "leiloes"
  add_foreign_key "leilao_convidados", "clientes"
  add_foreign_key "leilao_convidados", "leiloes"
  add_foreign_key "leilao_leiloeiros", "leiloeiros"
  add_foreign_key "leilao_leiloeiros", "leiloes"
  add_foreign_key "leilao_observacoes", "leiloes"
  add_foreign_key "leilao_observacoes", "users"
  add_foreign_key "leilao_padroes", "leiloes"
  add_foreign_key "leilao_patrocinadores", "leiloes"
  add_foreign_key "leilao_patrocinadores", "patrocinadores"
  add_foreign_key "leilao_promotores", "clientes"
  add_foreign_key "leilao_promotores", "leiloes"
  add_foreign_key "leilao_racas", "leiloes"
  add_foreign_key "leilao_racas", "racas"
  add_foreign_key "leiloeiros", "cidades"
  add_foreign_key "leiloes", "cidades"
  add_foreign_key "leiloes", "leilao_eventos"
  add_foreign_key "logradouros", "bairros"
  add_foreign_key "pagamento_parcelas", "pagamento_condicoes"
  add_foreign_key "planejamento_escalas", "funcoes"
  add_foreign_key "planejamento_escalas", "uniformes"
  add_foreign_key "planejamento_veiculos", "leiloes"
  add_foreign_key "planejamento_veiculos", "veiculos"
  add_foreign_key "planejamento_viagens", "planejamento_escalas"
  add_foreign_key "planejamento_viagens", "planejamento_veiculos"
  add_foreign_key "referencias", "clientes"
  add_foreign_key "tags", "clientes"
  add_foreign_key "taxa_automaticas", "leiloes"
  add_foreign_key "taxa_manuais", "leiloes"
  add_foreign_key "telefones", "clientes"
end
