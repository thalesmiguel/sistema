require 'rails_helper'

RSpec.describe ReferenciasController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/referencias/index.js.erb')
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

    it 'atribui novo Referencia para @referencia' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:referencia)).to be_a_new(Referencia)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:referencia, cliente_id: cliente) }

      it 'renderiza novo Referencia' do
        post :create, xhr: true, params: { cliente_id: cliente.id, referencia: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo referencia no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, referencia: dados_validos }
        }.to change(Referencia, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:referencia, cliente_id: cliente, nome: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, referencia: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo referencia no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, referencia: dados_invalidos }
        }.not_to change(Referencia, :count)
      end
    end

  end

  describe "GET edit" do
    let(:referencia) { FactoryGirl.create(:referencia, cliente: cliente) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: referencia }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o referencia selecionado para @referencia' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: referencia }
      expect(assigns(:referencia)).to eq(referencia)
    end

  end

  describe "PUT update" do
    let(:referencia) { FactoryGirl.create(:referencia, cliente: cliente) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:referencia, cliente_id: cliente, nome: "Thales") }

      it 'renderiza Referencia alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: referencia, referencia: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o referencia no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: referencia, referencia: dados_validos }
        referencia.reload
        expect(referencia.nome).to eq("Thales")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:referencia, cliente_id: cliente, nome: "", observacao: "observacao") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: referencia, referencia: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o referencia no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: referencia, referencia: dados_invalidos }
        referencia.reload
        expect(referencia.observacao).not_to eq("observacao")
      end

    end
  end

  describe "DELETE destroy" do
    let(:referencia) { FactoryGirl.create(:referencia, cliente: cliente) }

    it 'deleta Referencia da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: referencia }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta referencia do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: referencia }
      expect(Referencia.exists?(referencia.id)).to be_falsy
    end
  end

end
