require 'rails_helper'

RSpec.describe ClientesController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  describe "GET index" do

    it 'renderiza template :index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renderiza json' do
      get :index, xhr: true, format: :json
      expect(response).to_not be_nil
    end

  end

  describe "GET new" do

    it 'renderiza aba :new' do
      get :new, xhr: true, params: {}
      expect(response).to render_template('ajax/clientes/mostra_cliente.js.erb')
    end

    it 'atribui novo Cliente para @cliente' do
      get :new, xhr: true, params: {}
      expect(assigns(:cliente)).to be_a_new(Cliente)
    end
  end

  describe "POST create" do
    let(:dados_validos) { FactoryGirl.attributes_for(:cliente) }
    let(:dados_invalidos) { FactoryGirl.attributes_for(:cliente, nome: '') }

    context 'dados válidos' do
      it 'renderiza novo Cliente' do
        post :create, xhr: true, params: { cliente: dados_validos }
        expect(response).to render_template("ajax/clientes/mostra_novo_cliente.js.erb")
        # expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo cliente no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente: dados_validos }
        }.to change(Cliente, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo cliente no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente: dados_invalidos }
        }.not_to change(Cliente, :count)
      end
    end

  end

  describe "GET edit" do
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'mostra a tela de visualização' do
      get :edit, xhr: true, params: { id: cliente }
      expect(response).to render_template('ajax/clientes/mostra_cliente.js.erb')
    end

    it 'atribui o cliente selecionada para @cliente' do
      get :edit, xhr: true, params: { id: cliente }
      expect(assigns(:cliente)).to eq(cliente)
    end

  end

  describe "PUT update" do
    let(:cliente) { FactoryGirl.create(:cliente, nome: "Nome antigo") }

    let(:dados_validos) { FactoryGirl.attributes_for(:cliente, nome: "Novo nome") }
    let(:dados_invalidos) { FactoryGirl.attributes_for(:cliente, nome: '') }

    context 'dados válidos' do

      it 'renderiza Cliente alterada' do
        put :update, xhr: true, params: { id: cliente, cliente: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o cliente no banco de dados' do
        put :update, xhr: true, params: { id: cliente, cliente: dados_validos }
        cliente.reload
        expect(cliente.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: cliente, cliente: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o cliente no banco de dados' do
        put :update, xhr: true, params: { id: cliente, cliente: dados_invalidos }
        cliente.reload
        expect(cliente.nome).to eq("Nome antigo")
      end

    end

  end

  describe "DELETE destroy" do
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'deleta Cliente da tabela' do
      delete :destroy, xhr: true, params: { id: cliente }
      expect(response).to render_template("ajax/clientes/mostra_pesquisa.js.erb")
    end

    it 'deleta cliente do banco de dados' do
      delete :destroy, xhr: true, params: { id: cliente }
      expect(Cliente.exists?(cliente.id)).to be_falsy
    end


  end

end
