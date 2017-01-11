require 'rails_helper'

RSpec.describe ClienteBancosController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
  let(:banco) { FactoryGirl.create(:banco) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/cliente_bancos/index.js.erb')
    end

    it 'renderiza json' do
      get :index, xhr: true, format: :json, params: { cliente_id: cliente.id, banco: banco }
      expect(response).to_not be_nil
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { cliente_id: cliente.id, banco: banco }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo ClienteBanco para @cliente_banco' do
      get :new, xhr: true, params: { cliente_id: cliente.id, banco: banco }
      expect(assigns(:cliente_banco)).to be_a_new(ClienteBanco)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :new, xhr: true, params: { cliente_id: cliente.id, banco: banco }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", estado)
      get :new, xhr: true, params: { cliente_id: cliente.id, banco: banco }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:cliente_banco, cidade_id: cidade, cliente_id: cliente, banco_id: banco) }

      it 'renderiza novo ClienteBanco' do
        post :create, xhr: true, params: { cliente_id: cliente.id, cliente_banco: dados_validos}
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo cliente_banco no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, cliente_banco: dados_validos }
        }.to change(ClienteBanco, :count).by(1)
      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:cliente_banco, cidade_id: cidade, cliente_id: cliente, banco: nil) }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, cliente_banco: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo cliente_banco no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, cliente_banco: dados_invalidos }
        }.not_to change(ClienteBanco, :count)
      end
    end

  end

  describe "GET edit" do
    let(:cliente_banco) { FactoryGirl.create(:cliente_banco, cliente: cliente, cidade: cidade, banco: banco) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o cliente_banco selecionado para @cliente_banco' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco }
      expect(assigns(:cliente_banco)).to eq(cliente_banco)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", cliente_banco.cidade.estado_id)
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "PUT update" do
    let(:cliente_banco) { FactoryGirl.create(:cliente_banco, cliente: cliente, cidade: cidade, banco: banco) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:cliente_banco, cidade_id: cidade, banco_id: banco, cliente_id: cliente, agencia: "160") }

      it 'renderiza ClienteBanco alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco, cliente_banco: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o cliente_banco no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco, cliente_banco: dados_validos }
        cliente_banco.reload
        expect(cliente_banco.agencia).to eq("160")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:cliente_banco, cidade_id: cidade, banco_id: nil, cliente_id: cliente, agencia: "160") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco, cliente_banco: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o cliente_banco no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco, cliente_banco: dados_invalidos }
        cliente_banco.reload
        expect(cliente_banco.agencia).not_to eq("160")
      end

    end
  end

  describe "DELETE destroy" do
    let(:cliente_banco) { FactoryGirl.create(:cliente_banco, cliente: cliente, cidade: cidade, banco: banco) }

    it 'deleta ClienteBanco da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta cliente_banco do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: cliente_banco }
      expect(ClienteBanco.exists?(cliente_banco.id)).to be_falsy
    end
  end

end
