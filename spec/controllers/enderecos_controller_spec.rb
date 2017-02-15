require 'rails_helper'

RSpec.describe EnderecosController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/enderecos/index.js.erb')
    end
  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Endereco para @endereco' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:endereco)).to be_a_new(Endereco)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", estado)
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:endereco, cidade_id: cidade, cliente_id: cliente) }

      it 'renderiza novo Endereco' do
        post :create, xhr: true, params: { cliente_id: cliente.id, endereco: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo endereco no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, endereco: dados_validos }
        }.to change(Endereco, :count).by(1)
      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:endereco, cidade_id: cidade, cliente_id: cliente, logradouro: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, endereco: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo endereco no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, endereco: dados_invalidos }
        }.not_to change(Endereco, :count)
      end
    end

  end

  describe "GET edit" do
    let(:endereco) { FactoryGirl.create(:endereco, cliente: cliente, cidade: cidade) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: endereco }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o endereco selecionado para @endereco' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: endereco }
      expect(assigns(:endereco)).to eq(endereco)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: endereco }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", endereco.cidade.estado_id)
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: endereco }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "PUT update" do
    let(:endereco) { FactoryGirl.create(:endereco, cliente: cliente, cidade: cidade) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:endereco, cidade_id: cidade, cliente_id: cliente, logradouro: "Novo Logradouro", numero: "111") }

      it 'renderiza Endereco alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: endereco, endereco: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o endereco no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: endereco, endereco: dados_validos }
        endereco.reload
        expect(endereco.logradouro).to eq("Novo Logradouro")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:endereco, cidade_id: cidade, cliente_id: cliente, logradouro: "", numero: "222") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: endereco, endereco: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o endereco no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: endereco, endereco: dados_invalidos }
        endereco.reload
        expect(endereco.numero).not_to eq("222")
      end

    end
  end

  describe "DELETE destroy" do
    let(:endereco) { FactoryGirl.create(:endereco, cliente: cliente, cidade: cidade) }

    it 'deleta Endereco da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: endereco }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta endereco do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: endereco }
      expect(Endereco.exists?(endereco.id)).to be_falsy
    end
  end

end
