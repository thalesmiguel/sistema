require 'rails_helper'

RSpec.describe PagamentoCondicoesController, type: :controller do

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

    it 'atribui novo PagamentoCondicao para @pagamento_condicao' do
      get :new, xhr: true, params: {}
      expect(assigns(:pagamento_condicao)).to be_a_new(PagamentoCondicao)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo PagamentoCondicao' do
        post :create, xhr: true, params: { pagamento_condicao: FactoryGirl.attributes_for(:pagamento_condicao) }
        expect(response).to render_template("ajax/pagamento_condicoes/mostra_parcelas.js.erb")
      end

      it 'cria novo pagamento_condicao no banco de dados' do
        expect {
          post :create, xhr: true, params: { pagamento_condicao: FactoryGirl.attributes_for(:pagamento_condicao) }
        }.to change(PagamentoCondicao, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { pagamento_condicao: FactoryGirl.attributes_for(:pagamento_condicao, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo pagamento_condicao no banco de dados' do
        expect {
          post :create, xhr: true, params: { pagamento_condicao: FactoryGirl.attributes_for(:pagamento_condicao, nome: '') }
        }.not_to change(PagamentoCondicao, :count)
      end
    end

  end

  describe "GET edit" do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: pagamento_condicao }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o pagamento_condicao selecionado para @pagamento_condicao' do
      get :edit, xhr: true, params: { id: pagamento_condicao }
      expect(assigns(:pagamento_condicao)).to eq(pagamento_condicao)
    end

  end

  describe "PUT update" do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, captacoes: 1, parcelas: 1) }
    let(:parcela_id) { pagamento_condicao.pagamento_parcelas.first.id }
    let(:parcela) { FactoryGirl.attributes_for(:pagamento_parcela, id: parcela_id, captacoes: 1) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:pagamento_condicao, nome: "Novo nome") }

      it 'renderiza PagamentoCondicao alterado' do
        pagamento_condicao.reload
        put :update, xhr: true, params: { id: pagamento_condicao, pagamento_condicao: dados_validos }
        expect(response).to render_template("pagamento_condicoes/mostra_parcelas.js.erb")
      end

      it 'altera o pagamento_condicao no banco de dados' do
        put :update, xhr: true, params: { id: pagamento_condicao, pagamento_condicao: dados_validos }
        pagamento_condicao.reload
        expect(pagamento_condicao.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:pagamento_condicao, nome: "", tipo: "mensal", pagamento_parcelas_attributes: [parcela]) }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: pagamento_condicao, pagamento_condicao: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o pagamento_condicao no banco de dados' do
        put :update, xhr: true, params: { id: pagamento_condicao, pagamento_condicao: dados_invalidos }
        pagamento_condicao.reload
        expect(pagamento_condicao.tipo).not_to eq("mensal")
      end

    end
  end

  describe "DELETE destroy" do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao) }

    it 'deleta PagamentoCondicao da tabela' do
      delete :destroy, xhr: true, params: { id: pagamento_condicao }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta pagamento_condicao do banco de dados' do
      delete :destroy, xhr: true, params: { id: pagamento_condicao }
      expect(PagamentoCondicao.exists?(pagamento_condicao.id)).to be_falsy
    end

  end

end
