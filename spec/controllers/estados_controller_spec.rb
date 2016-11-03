require 'rails_helper'

RSpec.describe EstadosController, type: :controller do

  describe "GET index" do

    it 'renderiza template :index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'atribui todos os estados para @estados' do
      estados = FactoryGirl.create(:estado)
      get :index
      expect(assigns(:estados)).to match_array([estados])
    end
  end

  describe "GET new" do

    it 'renderiza o template :new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'atribui novo Estado para @estado' do
      get :new
      expect(assigns(:estado)).to be_a_new(Estado)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'redireciona para estados#index' do
        post :create, params: { estado: FactoryGirl.attributes_for(:estado) }
        expect(response).to redirect_to(estados_path)
      end

      it 'cria novo estado no banco de dados' do
        expect {
          post :create, params: { estado: FactoryGirl.attributes_for(:estado) }
        }.to change(Estado, :count).by(1)
      end
    end

    context 'dados inválidos' do
      it 'renderiza template :new' do
        post :create, params: { estado: FactoryGirl.attributes_for(:estado, nome: '') }
        expect(response).to render_template(:new)
      end

      it 'não cria novo estado no banco de dados' do
        expect {
          post :create, params: { estado: FactoryGirl.attributes_for(:estado, nome: '') }
        }.not_to change(Estado, :count)
      end
    end

  end

  describe "GET edit" do
    let(:estado) { FactoryGirl.create(:estado) }

    it 'renderiza template :edit' do
      get :edit, params: { id: estado }
      expect(response).to render_template(:edit)
    end

    it 'atribui o estado selecionado para @estado' do
      get :edit, params: { id: estado }
      expect(assigns(:estado)).to eq(estado)
    end

  end

  describe "PUT update" do
    let(:estado) { FactoryGirl.create(:estado) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:estado, nome: "Novo nome") }

      it 'redireciona para estados#index' do
        put :update, params: { id: estado, estado: dados_validos }
        expect(response).to redirect_to(estados_path)
      end

      it 'altera o estado no banco de dados' do
        put :update, params: { id:estado, estado: dados_validos }
        estado.reload
        expect(estado.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:estado, nome: "", sigla: "XX") }

      it 'renderiza template :edit' do
        put :update, params: { id: estado, estado: dados_invalidos }
        expect(response).to render_template(:edit)
      end

      it 'não altera o estado no banco de dados' do
        put :update, params: { id: estado, estado: dados_invalidos }
        estado.reload
        expect(estado.sigla).not_to eq("XX")
      end

    end
  end

  describe "DELETE destroy" do
    let(:estado) { FactoryGirl.create(:estado) }

    it 'redireciona para estado#index' do
      delete :destroy, params: { id: estado }
      expect(response).to redirect_to(estados_path)
    end

    it 'deleta estado do banco de dados' do
      delete :destroy, params: { id: estado }
      expect(Estado.exists?(estado.id)).to be_falsy
    end

  end

end
