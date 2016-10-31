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

ActiveRecord::Schema.define(version: 20161031192247) do

  create_table "bancos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "codigo"
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.boolean  "primario"
    t.boolean  "ativo"
    t.integer  "cliente_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
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
    t.text     "obsevacao",          limit: 65535
    t.string   "cadastrado_por"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "contato"
    t.boolean  "mala_direta"
    t.boolean  "solicitacao_email"
    t.boolean  "envio_contratos"
    t.boolean  "ativo"
    t.integer  "cliente_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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
    t.string   "pais"
    t.string   "cep"
    t.string   "aos_cuidados"
    t.boolean  "primario"
    t.boolean  "ativo"
    t.integer  "cliente_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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
    t.string   "endereco"
    t.string   "area"
    t.text     "observacao",         limit: 65535
    t.string   "inscricao_estadual"
    t.string   "cnpj_fazenda"
    t.string   "incra"
    t.string   "cnpj_produtor"
    t.string   "nome_nf"
    t.string   "cpf_cnpj_nf"
    t.boolean  "ativo"
    t.integer  "cliente_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["cidade_id"], name: "index_fazendas_on_cidade_id", using: :btree
    t.index ["cliente_id"], name: "index_fazendas_on_cliente_id", using: :btree
  end

  create_table "lancar_autorizados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "observacao"
    t.boolean  "tem_procuracao"
    t.boolean  "ativo"
    t.integer  "cliente_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["cliente_id"], name: "index_lancar_autorizados_on_cliente_id", using: :btree
  end

  create_table "referencias", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "observacao"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_referencias_on_cliente_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "codigo"
    t.string   "nome"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_tags_on_cliente_id", using: :btree
  end

  create_table "telefones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tipo"
    t.string   "ddi"
    t.string   "ddd"
    t.string   "numero"
    t.string   "ramal"
    t.string   "nome_contato"
    t.integer  "importancia"
    t.boolean  "telemarketing"
    t.boolean  "divulgar"
    t.boolean  "ativo"
    t.integer  "cliente_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["cliente_id"], name: "index_telefones_on_cliente_id", using: :btree
  end

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
  add_foreign_key "referencias", "clientes"
  add_foreign_key "tags", "clientes"
  add_foreign_key "telefones", "clientes"
end
