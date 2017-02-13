require 'rails_helper'

RSpec.describe LeilaoEventosController, type: :controller do

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

    it 'atribui novo LeilaoEvento para @leilao_evento' do
      get :new, xhr: true, params: {}
      expect(assigns(:leilao_evento)).to be_a_new(LeilaoEvento)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo LeilaoEvento' do
        post :create, xhr: true, params: { leilao_evento: FactoryGirl.attributes_for(:leilao_evento) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo leilao_evento no banco de dados' do
        expect {
          post :create, xhr: true, params: { leilao_evento: FactoryGirl.attributes_for(:leilao_evento) }
        }.to change(LeilaoEvento, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { leilao_evento: FactoryGirl.attributes_for(:leilao_evento, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo leilao_evento no banco de dados' do
        expect {
          post :create, xhr: true, params: { leilao_evento: FactoryGirl.attributes_for(:leilao_evento, nome: '') }
        }.not_to change(LeilaoEvento, :count)
      end
    end

  end

  describe "GET edit" do
    let(:leilao_evento) { FactoryGirl.create(:leilao_evento) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: leilao_evento }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o leilao_evento selecionado para @leilao_evento' do
      get :edit, xhr: true, params: { id: leilao_evento }
      expect(assigns(:leilao_evento)).to eq(leilao_evento)
    end

  end

  describe "PUT update" do
    let(:leilao_evento) { FactoryGirl.create(:leilao_evento) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:leilao_evento, nome: "Novo nome") }

      it 'renderiza LeilaoEvento alterado' do
        put :update, xhr: true, params: { id: leilao_evento, leilao_evento: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o leilao_evento no banco de dados' do
        put :update, xhr: true, params: { id:leilao_evento, leilao_evento: dados_validos }
        leilao_evento.reload
        expect(leilao_evento.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:leilao_evento, nome: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: leilao_evento, leilao_evento: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o leilao_evento no banco de dados' do
        put :update, xhr: true, params: { id: leilao_evento, leilao_evento: dados_invalidos }
        leilao_evento.reload
        expect(leilao_evento.nome).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:leilao_evento) { FactoryGirl.create(:leilao_evento) }

    it 'deleta LeilaoEvento da tabela' do
      delete :destroy, xhr: true, params: { id: leilao_evento }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta leilao_evento do banco de dados' do
      delete :destroy, xhr: true, params: { id: leilao_evento }
      expect(LeilaoEvento.exists?(leilao_evento.id)).to be_falsy
    end

  end

end
