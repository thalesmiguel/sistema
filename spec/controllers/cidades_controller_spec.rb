require 'rails_helper'

RSpec.describe CidadesController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  describe "GET index" do

    it 'renderiza template :index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renderiza json' do
      get :index, xhr: true, format: :json
      expect(response).to_not be_nil
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: {}
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui nova Cidade para @cidade' do
      get :new, xhr: true, params: {}
      expect(assigns(:cidade)).to be_a_new(Cidade)
    end
  end

  describe "POST create" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:dados_validos) { FactoryGirl.attributes_for(:cidade, estado: estado) }
    let(:dados_invalidos) { FactoryGirl.attributes_for(:cidade, estado: estado, nome: '') }

    context 'dados válidos' do
      it 'renderiza nova Cidade' do
        post :create, xhr: true, params: { cidade: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria nova cidade no banco de dados' do
        expect {
          post :create, xhr: true, params: { cidade: dados_validos }
        }.to change(Cidade, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cidade: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria nova cidade no banco de dados' do
        expect {
          post :create, xhr: true, params: { cidade: dados_invalidos }
        }.not_to change(Cidade, :count)
      end
    end

  end

  describe "GET edit" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: cidade }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui a cidade selecionada para @cidade' do
      get :edit, xhr: true, params: { id: cidade }
      expect(assigns(:cidade)).to eq(cidade)
    end

  end

  describe "PUT update" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado, nome: "Nome antigo") }

    let(:dados_validos) { FactoryGirl.attributes_for(:cidade, estado: estado, nome: "Novo nome") }
    let(:dados_invalidos) { FactoryGirl.attributes_for(:cidade, estado: estado, nome: '') }

    context 'dados válidos' do

      it 'renderiza Cidade alterada' do
        put :update, xhr: true, params: { id: cidade, cidade: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera a cidade no banco de dados' do
        put :update, xhr: true, params: { id: cidade, cidade: dados_validos }
        cidade.reload
        expect(cidade.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: cidade, cidade: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera a cidade no banco de dados' do
        put :update, xhr: true, params: { id: cidade, cidade: dados_invalidos }
        cidade.reload
        expect(cidade.nome).to eq("Nome antigo")
      end

    end

  end

  describe "DELETE destroy" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    it 'deleta Cidade da tabela' do
      delete :destroy, xhr: true, params: { id: cidade }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta cidade do banco de dados' do
      delete :destroy, xhr: true, params: { id: cidade }
      expect(Cidade.exists?(cidade.id)).to be_falsy
    end


  end

end
