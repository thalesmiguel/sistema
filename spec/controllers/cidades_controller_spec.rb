require 'rails_helper'

RSpec.describe CidadesController, type: :controller do

  describe "GET index" do

    it 'renderiza template :index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'atribui todos as cidades para @cidades' do
      estado = FactoryGirl.create(:estado)
      cidades = FactoryGirl.create(:cidade, estado: estado)
      get :index
      expect(assigns(:cidades)).to match_array([cidades])
    end
  end

  describe "GET new" do

    it 'renderiza o template :new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'atribui nova Cidade para @cidade' do
      get :new
      expect(assigns(:cidade)).to be_a_new(Cidade)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      let(:estado) { FactoryGirl.create(:estado) }

      it 'redireciona para cidades#index' do
        post :create, params: { cidade: FactoryGirl.attributes_for(:cidade, estado_id: estado) }
        expect(response).to redirect_to(cidades_path)
      end

      it 'cria nova cidade no banco de dados' do
        expect {
          post :create, params: { cidade: FactoryGirl.attributes_for(:cidade, estado_id: estado) }
        }.to change(Cidade, :count).by(1)
      end
    end

    context 'dados inválidos' do
      it 'renderiza template :new' do
        post :create, params: { cidade: FactoryGirl.attributes_for(:cidade, nome: '') }
        expect(response).to render_template(:new)
      end

      it 'não cria nova cidade no banco de dados' do
        expect {
          post :create, params: { cidade: FactoryGirl.attributes_for(:cidade, nome: '') }
        }.not_to change(Cidade, :count)
      end
    end

  end

  describe "GET edit" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    it 'renderiza template :edit' do
      get :edit, params: { id: cidade }
      expect(response).to render_template(:edit)
    end

    it 'atribui a cidade selecionado para @cidade' do
      get :edit, params: { id: cidade }
      expect(assigns(:cidade)).to eq(cidade)
    end

  end

  describe "PUT update" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:cidade, nome: "Novo nome", estado: estado) }

      it 'redireciona para cidades#index' do
        put :update, params: { id: cidade, cidade: dados_validos }
        expect(response).to redirect_to(cidades_path)
      end

      it 'altera a cidade no banco de dados' do
        put :update, params: { id: cidade, cidade: dados_validos }
        cidade.reload
        expect(cidade.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:cidade, nome: "", estado: estado) }

      it 'renderiza template :edit' do
        put :update, params: { id: cidade, cidade: dados_invalidos }
        expect(response).to render_template(:edit)
      end

      it 'não altera a cidade no banco de dados' do
        put :update, params: { id: cidade, cidade: dados_invalidos }
        cidade.reload
        expect(cidade.nome).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    it 'redireciona para cidade#index' do
      delete :destroy, params: { id: cidade }
      expect(response).to redirect_to(cidades_path)
    end

    it 'deleta cidade do banco de dados' do
      delete :destroy, params: { id: cidade }
      expect(Cidade.exists?(cidade.id)).to be_falsy
    end

  end

end
