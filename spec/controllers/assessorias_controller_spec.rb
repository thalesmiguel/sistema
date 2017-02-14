require 'rails_helper'

RSpec.describe AssessoriasController, type: :controller do

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

    it 'atribui novo Assessoria para @assessoria' do
      get :new, xhr: true, params: {}
      expect(assigns(:assessoria)).to be_a_new(Assessoria)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Assessoria' do
        post :create, xhr: true, params: { assessoria: FactoryGirl.attributes_for(:assessoria, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo assessoria no banco de dados' do
        expect {
          post :create, xhr: true, params: { assessoria: FactoryGirl.attributes_for(:assessoria, logo: '') }
        }.to change(Assessoria, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { assessoria: FactoryGirl.attributes_for(:assessoria, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo assessoria no banco de dados' do
        expect {
          post :create, xhr: true, params: { assessoria: FactoryGirl.attributes_for(:assessoria, nome: "", logo: '') }
        }.not_to change(Assessoria, :count)
      end
    end

  end

  describe "GET edit" do
    let(:assessoria) { FactoryGirl.create(:assessoria) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: assessoria }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o assessoria selecionado para @assessoria' do
      get :edit, xhr: true, params: { id: assessoria }
      expect(assigns(:assessoria)).to eq(assessoria)
    end

  end

  describe "PUT update" do
    let(:assessoria) { FactoryGirl.create(:assessoria) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:assessoria, nome: "Novo nome", logo: '') }

      it 'renderiza Assessoria alterado' do
        put :update, xhr: true, params: { id: assessoria, assessoria: dados_validos, logo: '' }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o assessoria no banco de dados' do
        put :update, xhr: true, params: { id:assessoria, assessoria: dados_validos, logo: '' }
        assessoria.reload
        expect(assessoria.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:assessoria, nome: "", logo: '') }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: assessoria, assessoria: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o assessoria no banco de dados' do
        put :update, xhr: true, params: { id: assessoria, assessoria: dados_invalidos }
        assessoria.reload
        expect(assessoria.nome).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:assessoria) { FactoryGirl.create(:assessoria) }

    it 'deleta Assessoria da tabela' do
      delete :destroy, xhr: true, params: { id: assessoria }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta assessoria do banco de dados' do
      delete :destroy, xhr: true, params: { id: assessoria }
      expect(Assessoria.exists?(assessoria.id)).to be_falsy
    end

  end

end
