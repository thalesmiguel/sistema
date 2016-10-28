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

ActiveRecord::Schema.define(version: 20161028175516) do

  create_table "cidades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id", using: :btree
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
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
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

  add_foreign_key "cidades", "estados"
  add_foreign_key "enderecos", "cidades"
  add_foreign_key "enderecos", "clientes"
end
