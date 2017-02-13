require 'rails_helper'

RSpec.describe SubtiposController, type: :controller do

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

    it 'atribui novo Subtipo para @subtipo' do
      get :new, xhr: true, params: {}
      expect(assigns(:subtipo)).to be_a_new(Subtipo)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Subtipo' do
        post :create, xhr: true, params: { subtipo: FactoryGirl.attributes_for(:subtipo) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo subtipo no banco de dados' do
        expect {
          post :create, xhr: true, params: { subtipo: FactoryGirl.attributes_for(:subtipo) }
        }.to change(Subtipo, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { subtipo: FactoryGirl.attributes_for(:subtipo, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo subtipo no banco de dados' do
        expect {
          post :create, xhr: true, params: { subtipo: FactoryGirl.attributes_for(:subtipo, nome: '') }
        }.not_to change(Subtipo, :count)
      end
    end

  end

  describe "GET edit" do
    let(:subtipo) { FactoryGirl.create(:subtipo) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: subtipo }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o subtipo selecionado para @subtipo' do
      get :edit, xhr: true, params: { id: subtipo }
      expect(assigns(:subtipo)).to eq(subtipo)
    end

  end

  describe "PUT update" do
    let(:subtipo) { FactoryGirl.create(:subtipo) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:subtipo, nome: "Novo nome") }

      it 'renderiza Subtipo alterado' do
        put :update, xhr: true, params: { id: subtipo, subtipo: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o subtipo no banco de dados' do
        put :update, xhr: true, params: { id:subtipo, subtipo: dados_validos }
        subtipo.reload
        expect(subtipo.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:subtipo, nome: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: subtipo, subtipo: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o subtipo no banco de dados' do
        put :update, xhr: true, params: { id: subtipo, subtipo: dados_invalidos }
        subtipo.reload
        expect(subtipo.nome).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:subtipo) { FactoryGirl.create(:subtipo) }

    it 'deleta Subtipo da tabela' do
      delete :destroy, xhr: true, params: { id: subtipo }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta subtipo do banco de dados' do
      delete :destroy, xhr: true, params: { id: subtipo }
      expect(Subtipo.exists?(subtipo.id)).to be_falsy
    end

  end

end
