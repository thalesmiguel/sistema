require 'rails_helper'

RSpec.describe AlertasController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:cliente) { FactoryGirl.create(:cliente) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id, user_id: user.id }
      expect(response).to render_template('ajax/clientes/alertas/index.js.erb')
    end

    # it 'renderiza json' do
    #   get :index, xhr: true, format: :json, params: { cliente_id: cliente.id, user_id: user.id }
    #   expect(response).to_not be_nil
    # end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { cliente_id: cliente.id, user_id: user.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Alerta para @alerta' do
      get :new, xhr: true, params: { cliente_id: cliente.id, user_id: user.id }
      expect(assigns(:alerta)).to be_a_new(Alerta)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:alerta, cliente_id: cliente, user_id: user) }

      it 'renderiza novo Alerta' do
        post :create, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, alerta: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo alerta no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, alerta: dados_validos }
        }.to change(Alerta, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:alerta, cliente_id: cliente, user_id: user.id, descricao: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, alerta: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo alerta no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, alerta: dados_invalidos }
        }.not_to change(Alerta, :count)
      end
    end

  end

  describe "GET edit" do
    let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user_id: user.id) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o alerta selecionado para @alerta' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta }
      expect(assigns(:alerta)).to eq(alerta)
    end

  end

  describe "PUT update" do
    let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user_id: user.id) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:alerta, cliente_id: cliente, user_id: user.id, descricao: "Descrição completa") }

      it 'renderiza Alerta alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta, alerta: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o alerta no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta, alerta: dados_validos }
        alerta.reload
        expect(alerta.descricao).to eq("Descrição completa")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:alerta, cliente_id: cliente, user_id: user.id, descricao: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta, alerta: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o alerta no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta, alerta: dados_invalidos }
        alerta.reload
        expect(alerta.descricao).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user_id: user.id) }

    it 'deleta Alerta da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta alerta do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, user_id: user.id, id: alerta }
      expect(Alerta.exists?(alerta.id)).to be_falsy
    end
  end

end
