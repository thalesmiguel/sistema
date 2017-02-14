require 'rails_helper'

RSpec.describe PatrocinadoresController, type: :controller do

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

    it 'atribui novo Patrocinador para @patrocinador' do
      get :new, xhr: true, params: {}
      expect(assigns(:patrocinador)).to be_a_new(Patrocinador)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Patrocinador' do
        post :create, xhr: true, params: { patrocinador: FactoryGirl.attributes_for(:patrocinador, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo patrocinador no banco de dados' do
        expect {
          post :create, xhr: true, params: { patrocinador: FactoryGirl.attributes_for(:patrocinador, logo: '') }
        }.to change(Patrocinador, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { patrocinador: FactoryGirl.attributes_for(:patrocinador, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo patrocinador no banco de dados' do
        expect {
          post :create, xhr: true, params: { patrocinador: FactoryGirl.attributes_for(:patrocinador, nome: "", logo: '') }
        }.not_to change(Patrocinador, :count)
      end
    end

  end

  describe "GET edit" do
    let(:patrocinador) { FactoryGirl.create(:patrocinador) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: patrocinador }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o patrocinador selecionado para @patrocinador' do
      get :edit, xhr: true, params: { id: patrocinador }
      expect(assigns(:patrocinador)).to eq(patrocinador)
    end

  end

  describe "PUT update" do
    let(:patrocinador) { FactoryGirl.create(:patrocinador) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:patrocinador, nome: "Novo nome", logo: '') }

      it 'renderiza Patrocinador alterado' do
        put :update, xhr: true, params: { id: patrocinador, patrocinador: dados_validos, logo: '' }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o patrocinador no banco de dados' do
        put :update, xhr: true, params: { id:patrocinador, patrocinador: dados_validos, logo: '' }
        patrocinador.reload
        expect(patrocinador.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:patrocinador, nome: "", logo: '') }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: patrocinador, patrocinador: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o patrocinador no banco de dados' do
        put :update, xhr: true, params: { id: patrocinador, patrocinador: dados_invalidos }
        patrocinador.reload
        expect(patrocinador.nome).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:patrocinador) { FactoryGirl.create(:patrocinador) }

    it 'deleta Patrocinador da tabela' do
      delete :destroy, xhr: true, params: { id: patrocinador }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta patrocinador do banco de dados' do
      delete :destroy, xhr: true, params: { id: patrocinador }
      expect(Patrocinador.exists?(patrocinador.id)).to be_falsy
    end

  end

end
