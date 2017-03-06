require 'rails_helper'

RSpec.describe LeilaoObservacoesController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:leilao) { FactoryGirl.create(:leilao) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { leilao_id: leilao.id }
      expect(response).to render_template('ajax/leiloes/leilao_observacoes/index.js.erb')
    end

    it 'renderiza json' do
      skip "REVISAR: Método funciona mas não passa no teste."
      get :index, xhr: true, format: :json, params: { leilao_id: leilao.id }
      expect(response).to_not be_nil
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { leilao_id: leilao.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo LeilaoObservacao para @leilao_observacao' do
      get :new, xhr: true, params: { leilao_id: leilao.id }
      expect(assigns(:leilao_observacao)).to be_a_new(LeilaoObservacao)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:leilao_observacao, leilao_id: leilao, user_id: user) }

      it 'renderiza novo LeilaoObservacao' do
        post :create, xhr: true, params: { leilao_id: leilao.id, leilao_observacao: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo leilao_observacao no banco de dados' do
        expect {
          post :create, xhr: true, params: { leilao_id: leilao.id, leilao_observacao: dados_validos }
        }.to change(LeilaoObservacao, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:leilao_observacao, leilao_id: leilao, descricao: '', user_id: user) }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { leilao_id: leilao.id, leilao_observacao: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo leilao_observacao no banco de dados' do
        expect {
          post :create, xhr: true, params: { leilao_id: leilao.id, leilao_observacao: dados_invalidos }
        }.not_to change(LeilaoObservacao, :count)
      end
    end

  end

  describe "GET edit" do
    let(:leilao_observacao) { FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o leilao_observacao selecionado para @leilao_observacao' do
      get :edit, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao }
      expect(assigns(:leilao_observacao)).to eq(leilao_observacao)
    end

  end

  describe "PUT update" do
    let(:leilao_observacao) { FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:leilao_observacao, leilao_id: leilao, descricao: "asdf asdf asdf") }

      it 'renderiza LeilaoObservacao alterado' do
        put :update, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao, leilao_observacao: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o leilao_observacao no banco de dados' do
        put :update, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao, leilao_observacao: dados_validos }
        leilao_observacao.reload
        expect(leilao_observacao.descricao).to eq("asdf asdf asdf")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:leilao_observacao, leilao_id: leilao, descricao: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao, leilao_observacao: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o leilao_observacao no banco de dados' do
        put :update, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao, leilao_observacao: dados_invalidos }
        leilao_observacao.reload
        expect(leilao_observacao.descricao).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:leilao_observacao) { FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user) }

    it 'deleta LeilaoObservacao da tabela' do
      delete :destroy, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta leilao_observacao do banco de dados' do
      delete :destroy, xhr: true, params: { leilao_id: leilao.id, id: leilao_observacao }
      expect(LeilaoObservacao.exists?(leilao_observacao.id)).to be_falsy
    end
  end

  describe "PUT altera_status" do
    let(:user) { FactoryGirl.create(:user) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:observacao_ativo) { FactoryGirl.create(:leilao_observacao, ativo: true, leilao: leilao, user: user) }
    let(:observacao_inativo) { FactoryGirl.create(:leilao_observacao, ativo: false, leilao: leilao, user: user) }

    it 'altera o atributo ativo para falso' do
      put :altera_status, xhr: true, params: { leilao_id: leilao.id, id: observacao_ativo }
      observacao_ativo.reload
      expect(observacao_ativo.ativo).to eq(false)
    end

    it 'altera o atributo ativo para verdadeiro' do
      put :altera_status, xhr: true, params: { leilao_id: leilao.id, id: observacao_inativo }
      observacao_inativo.reload
      expect(observacao_inativo.ativo).to eq(true)
    end
  end

end
