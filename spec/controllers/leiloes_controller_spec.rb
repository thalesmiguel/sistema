require 'rails_helper'

RSpec.describe LeiloesController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  describe "GET index" do

    it 'renderiza template :index' do
      get :index, xhr: true
      expect(response).to render_template('ajax/leiloes/lista_leiloes.js.erb')
    end
  end

  describe "GET new" do

    it 'renderiza aba :new' do
      get :new, xhr: true, params: {}
      expect(response).to render_template('ajax/leiloes/mostra_leilao.js.erb')
    end

    it 'atribui novo Leilao para @leilao' do
      get :new, xhr: true, params: {}
      expect(assigns(:leilao)).to be_a_new(Leilao)
    end
  end

  describe "POST create" do
    let(:dados_validos) { FactoryGirl.attributes_for(:leilao, logo: nil) }
    let(:dados_invalidos) { FactoryGirl.attributes_for(:leilao, nome: '', logo: nil) }

    context 'dados válidos' do
      it 'renderiza novo Leilao' do
        post :create, xhr: true, params: { leilao: dados_validos }
        expect(response).to render_template("ajax/leiloes/mostra_novo_leilao.js.erb")
        # expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo leilao no banco de dados' do
        expect {
          post :create, xhr: true, params: { leilao: dados_validos }
        }.to change(Leilao, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { leilao: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo leilao no banco de dados' do
        expect {
          post :create, xhr: true, params: { leilao: dados_invalidos }
        }.not_to change(Leilao, :count)
      end
    end

  end

  describe "GET edit" do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'mostra a tela de visualização' do
      get :edit, params: { id: leilao }
      expect(response).to render_template(:edit)
    end

    it 'atribui o leilao selecionada para @leilao' do
      get :edit, xhr: true, params: { id: leilao }
      expect(assigns(:leilao)).to eq(leilao)
    end

  end

  describe "PUT update" do
    let(:leilao) { FactoryGirl.create(:leilao, nome: "Nome antigo") }

    let(:dados_validos) { FactoryGirl.attributes_for(:leilao, nome: "Novo nome", logo: nil) }
    let(:dados_invalidos) { FactoryGirl.attributes_for(:leilao, nome: '', logo: nil) }

    context 'dados válidos' do

      it 'renderiza Leilao alterada' do
        put :update, xhr: true, params: { id: leilao, leilao: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o leilao no banco de dados' do
        put :update, xhr: true, params: { id: leilao, leilao: dados_validos }
        leilao.reload
        expect(leilao.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: leilao, leilao: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o leilao no banco de dados' do
        put :update, xhr: true, params: { id: leilao, leilao: dados_invalidos }
        leilao.reload
        expect(leilao.nome).to eq("Nome antigo")
      end

    end

  end

  describe "DELETE destroy" do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'deleta Leilao da tabela' do
      delete :destroy, xhr: true, params: { id: leilao }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta leilao do banco de dados' do
      delete :destroy, xhr: true, params: { id: leilao }
      expect(Leilao.exists?(leilao.id)).to be_falsy
    end
  end

  describe "PUT seleciona_leilao" do
    let(:leilao) { FactoryGirl.create(:leilao, nome: "Nome antigo") }

    it 'atribui o Leilao selecionado à session[:leilao_id]' do
      put :seleciona_leilao, xhr: true, params: { id: leilao }
      expect(session[:leilao_id]).to eq leilao.id
    end

    it 'renderiza template seleciona_leilao.js.erb' do
      put :seleciona_leilao, xhr: true, params: { id: leilao }
      expect(response).to render_template("ajax/leiloes/seleciona_leilao.js.erb")
    end
  end
end
