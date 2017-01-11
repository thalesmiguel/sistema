require 'rails_helper'

RSpec.describe LancarAutorizadosController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/lancar_autorizados/index.js.erb')
    end

    it 'renderiza json' do
      get :index, xhr: true, format: :json, params: { cliente_id: cliente.id }
      expect(response).to_not be_nil
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo LancarAutorizado para @lancar_autorizado' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:lancar_autorizado)).to be_a_new(LancarAutorizado)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:lancar_autorizado, cliente_id: cliente, procuracao: '') }

      it 'renderiza novo LancarAutorizado' do
        post :create, xhr: true, params: { cliente_id: cliente.id, lancar_autorizado: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo lancar_autorizado no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, lancar_autorizado: dados_validos }
        }.to change(LancarAutorizado, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:lancar_autorizado, cliente_id: cliente, nome: '', procuracao: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, lancar_autorizado: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo lancar_autorizado no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, lancar_autorizado: dados_invalidos }
        }.not_to change(LancarAutorizado, :count)
      end
    end

  end

  describe "GET edit" do
    let(:lancar_autorizado) { FactoryGirl.create(:lancar_autorizado, cliente: cliente) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o lancar_autorizado selecionado para @lancar_autorizado' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado }
      expect(assigns(:lancar_autorizado)).to eq(lancar_autorizado)
    end

  end

  describe "PUT update" do
    let(:lancar_autorizado) { FactoryGirl.create(:lancar_autorizado, cliente: cliente) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:lancar_autorizado, cliente_id: cliente, nome: "Thales", procuracao: '') }

      it 'renderiza LancarAutorizado alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado, lancar_autorizado: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o lancar_autorizado no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado, lancar_autorizado: dados_validos }
        lancar_autorizado.reload
        expect(lancar_autorizado.nome).to eq("Thales")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:lancar_autorizado, cliente_id: cliente, nome: "", observacao: "observacao", procuracao: '') }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado, lancar_autorizado: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o lancar_autorizado no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado, lancar_autorizado: dados_invalidos }
        lancar_autorizado.reload
        expect(lancar_autorizado.observacao).not_to eq("observacao")
      end

    end
  end

  describe "DELETE destroy" do
    let(:lancar_autorizado) { FactoryGirl.create(:lancar_autorizado, cliente: cliente) }

    it 'deleta LancarAutorizado da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta lancar_autorizado do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: lancar_autorizado }
      expect(LancarAutorizado.exists?(lancar_autorizado.id)).to be_falsy
    end
  end

end
