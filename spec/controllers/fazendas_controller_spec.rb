require 'rails_helper'

RSpec.describe FazendasController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/fazendas/index.js.erb')
    end

    # it 'renderiza json' do
    #   get :index, xhr: true, format: :json, params: { cliente_id: cliente.id }
    #   expect(response).to_not be_nil
    # end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Fazenda para @fazenda' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:fazenda)).to be_a_new(Fazenda)
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
      let(:dados_validos) { FactoryGirl.attributes_for(:fazenda, cidade_id: cidade, cliente_id: cliente) }

      it 'renderiza novo Fazenda' do
        post :create, xhr: true, params: { cliente_id: cliente.id, fazenda: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo fazenda no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, fazenda: dados_validos }
        }.to change(Fazenda, :count).by(1)
      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:fazenda, cidade_id: cidade, cliente_id: cliente, nome: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, fazenda: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo fazenda no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, fazenda: dados_invalidos }
        }.not_to change(Fazenda, :count)
      end
    end

  end

  describe "GET edit" do
    let(:fazenda) { FactoryGirl.create(:fazenda, cliente: cliente, cidade: cidade) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: fazenda }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o fazenda selecionado para @fazenda' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: fazenda }
      expect(assigns(:fazenda)).to eq(fazenda)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: fazenda }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", fazenda.cidade.estado_id)
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: fazenda }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "PUT update" do
    let(:fazenda) { FactoryGirl.create(:fazenda, cliente: cliente, cidade: cidade) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:fazenda, cidade_id: cidade, cliente_id: cliente, nome: "Nova Fazenda", cep: "16020365") }

      it 'renderiza Fazenda alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: fazenda, fazenda: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o fazenda no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: fazenda, fazenda: dados_validos }
        fazenda.reload
        expect(fazenda.nome).to eq("Nova Fazenda")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:fazenda, cidade_id: cidade, cliente_id: cliente, nome: "", cep: "16020365") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: fazenda, fazenda: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o fazenda no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: fazenda, fazenda: dados_invalidos }
        fazenda.reload
        expect(fazenda.cep).not_to eq("16020365")
      end

    end
  end

  describe "DELETE destroy" do
    let(:fazenda) { FactoryGirl.create(:fazenda, cliente: cliente, cidade: cidade) }

    it 'deleta Fazenda da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: fazenda }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta fazenda do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: fazenda }
      expect(Fazenda.exists?(fazenda.id)).to be_falsy
    end
  end

end
