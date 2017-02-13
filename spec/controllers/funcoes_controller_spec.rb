require 'rails_helper'

RSpec.describe FuncoesController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  describe "GET index" do

    it 'renderiza template :index' do
      get :index
      expect(response).to render_template(:index)
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: {}
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Funcao para @funcao' do
      get :new, xhr: true, params: {}
      expect(assigns(:funcao)).to be_a_new(Funcao)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Funcao' do
        post :create, xhr: true, params: { funcao: FactoryGirl.attributes_for(:funcao) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo funcao no banco de dados' do
        expect {
          post :create, xhr: true, params: { funcao: FactoryGirl.attributes_for(:funcao) }
        }.to change(Funcao, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { funcao: FactoryGirl.attributes_for(:funcao, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo funcao no banco de dados' do
        expect {
          post :create, xhr: true, params: { funcao: FactoryGirl.attributes_for(:funcao, nome: '') }
        }.not_to change(Funcao, :count)
      end
    end

  end

  describe "GET edit" do
    let(:funcao) { FactoryGirl.create(:funcao) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: funcao }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o funcao selecionado para @funcao' do
      get :edit, xhr: true, params: { id: funcao }
      expect(assigns(:funcao)).to eq(funcao)
    end

  end

  describe "PUT update" do
    let(:funcao) { FactoryGirl.create(:funcao) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:funcao, nome: "Novo nome") }

      it 'renderiza Funcao alterado' do
        put :update, xhr: true, params: { id: funcao, funcao: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o funcao no banco de dados' do
        put :update, xhr: true, params: { id:funcao, funcao: dados_validos }
        funcao.reload
        expect(funcao.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:funcao, nome: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: funcao, funcao: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o funcao no banco de dados' do
        put :update, xhr: true, params: { id: funcao, funcao: dados_invalidos }
        funcao.reload
        expect(funcao.nome).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:funcao) { FactoryGirl.create(:funcao) }

    it 'deleta Funcao da tabela' do
      delete :destroy, xhr: true, params: { id: funcao }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta funcao do banco de dados' do
      delete :destroy, xhr: true, params: { id: funcao }
      expect(Funcao.exists?(funcao.id)).to be_falsy
    end

  end

end
