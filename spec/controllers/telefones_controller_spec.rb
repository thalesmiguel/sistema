require 'rails_helper'

RSpec.describe TelefonesController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/telefones/index.js.erb')
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

    it 'atribui novo Telefone para @telefone' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:telefone)).to be_a_new(Telefone)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:telefone, cliente_id: cliente) }

      it 'renderiza novo Telefone' do
        post :create, xhr: true, params: { cliente_id: cliente.id, telefone: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo telefone no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, telefone: dados_validos }
        }.to change(Telefone, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:telefone, cliente_id: cliente, numero: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, telefone: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo telefone no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, telefone: dados_invalidos }
        }.not_to change(Telefone, :count)
      end
    end

  end

  describe "GET edit" do
    let(:telefone) { FactoryGirl.create(:telefone, cliente: cliente) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: telefone }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o telefone selecionado para @telefone' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: telefone }
      expect(assigns(:telefone)).to eq(telefone)
    end

  end

  describe "PUT update" do
    let(:telefone) { FactoryGirl.create(:telefone, cliente: cliente) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:telefone, cliente_id: cliente, numero: "991344423") }

      it 'renderiza Telefone alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: telefone, telefone: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o telefone no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: telefone, telefone: dados_validos }
        telefone.reload
        expect(telefone.numero).to eq("991344423")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:telefone, cliente_id: cliente, ddd: "", numero: "991344423") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: telefone, telefone: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o telefone no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: telefone, telefone: dados_invalidos }
        telefone.reload
        expect(telefone.numero).not_to eq("018991344423")
      end

    end
  end

  describe "DELETE destroy" do
    let(:telefone) { FactoryGirl.create(:telefone, cliente: cliente) }

    it 'deleta Telefone da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: telefone }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta telefone do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: telefone }
      expect(Telefone.exists?(telefone.id)).to be_falsy
    end
  end

end
