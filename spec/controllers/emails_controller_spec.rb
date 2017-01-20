require 'rails_helper'

RSpec.describe EmailsController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/emails/index.js.erb')
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

    it 'atribui novo Email para @email' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:email)).to be_a_new(Email)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:email, cliente_id: cliente) }

      it 'renderiza novo Email' do
        post :create, xhr: true, params: { cliente_id: cliente.id, email: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo email no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, email: dados_validos }
        }.to change(Email, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:email, cliente_id: cliente, email: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, email: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo email no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, email: dados_invalidos }
        }.not_to change(Email, :count)
      end
    end

  end

  describe "GET edit" do
    let(:email) { FactoryGirl.create(:email, cliente: cliente) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: email }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o email selecionado para @email' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: email }
      expect(assigns(:email)).to eq(email)
    end

  end

  describe "PUT update" do
    let(:email) { FactoryGirl.create(:email, cliente: cliente) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:email, cliente_id: cliente, email: "thales.miguel@gmail.com") }

      it 'renderiza Email alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: email, email: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o email no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: email, email: dados_validos }
        email.reload
        expect(email.email).to eq("thales.miguel@gmail.com")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:email, cliente_id: cliente, email: "", contato: "Bozo") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: email, email: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o email no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: email, email: dados_invalidos }
        email.reload
        expect(email.contato).not_to eq("Bozo")
      end

    end
  end

  describe "DELETE destroy" do
    let(:email) { FactoryGirl.create(:email, cliente: cliente) }

    it 'deleta Email da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: email }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta email do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: email }
      expect(Email.exists?(email.id)).to be_falsy
    end
  end

end
