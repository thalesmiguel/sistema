require 'rails_helper'

RSpec.describe BancosController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true
      expect(response).to render_template(:index)
    end

    # it 'renderiza json' do
    #   get :index, xhr: true, format: :json
    #   expect(response).to_not be_nil
    # end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Banco para @banco' do
      get :new, xhr: true
      expect(assigns(:banco)).to be_a_new(Banco)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:banco) }

      it 'renderiza novo Banco' do
        post :create, xhr: true, params: { banco: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo banco no banco de dados' do
        expect {
          post :create, xhr: true, params: { banco: dados_validos }
        }.to change(Banco, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:banco, nome: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { banco: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo banco no banco de dados' do
        expect {
          post :create, xhr: true, params: { banco: dados_invalidos }
        }.not_to change(Banco, :count)
      end
    end

  end

  describe "GET edit" do
    let(:banco) { FactoryGirl.create(:banco) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: banco }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o banco selecionado para @banco' do
      get :edit, xhr: true, params: { id: banco }
      expect(assigns(:banco)).to eq(banco)
    end

  end

  describe "PUT update" do
    let(:banco) { FactoryGirl.create(:banco) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:banco, codigo: "001") }

      it 'renderiza Banco alterado' do
        put :update, xhr: true, params: { id: banco, banco: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o banco no banco de dados' do
        put :update, xhr: true, params: { id: banco, banco: dados_validos }
        banco.reload
        expect(banco.codigo).to eq("001")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:banco, codigo: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: banco, banco: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o banco no banco de dados' do
        put :update, xhr: true, params: { id: banco, banco: dados_invalidos }
        banco.reload
        expect(banco.codigo).not_to eq("001")
      end

    end
  end

  describe "DELETE destroy" do
    let(:banco) { FactoryGirl.create(:banco) }

    it 'deleta Banco da tabela' do
      delete :destroy, xhr: true, params: { id: banco }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta banco do banco de dados' do
      delete :destroy, xhr: true, params: { id: banco }
      expect(Banco.exists?(banco.id)).to be_falsy
    end
  end


  describe "GET lista_bancos" do
    it 'renderiza template :mostra_modal' do
      get :lista_bancos, xhr: true
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'renderiza json' do
      get :lista_bancos, xhr: true
      expect(response).to_not be_nil
    end

  end

end
