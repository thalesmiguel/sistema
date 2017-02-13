require 'rails_helper'

RSpec.describe BandeirasController, type: :controller do

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

    it 'atribui novo Bandeira para @bandeira' do
      get :new, xhr: true, params: {}
      expect(assigns(:bandeira)).to be_a_new(Bandeira)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Bandeira' do
        post :create, xhr: true, params: { bandeira: FactoryGirl.attributes_for(:bandeira, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo bandeira no banco de dados' do
        expect {
          post :create, xhr: true, params: { bandeira: FactoryGirl.attributes_for(:bandeira, logo: '') }
        }.to change(Bandeira, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { bandeira: FactoryGirl.attributes_for(:bandeira, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo bandeira no banco de dados' do
        expect {
          post :create, xhr: true, params: { bandeira: FactoryGirl.attributes_for(:bandeira, nome: "", logo: '') }
        }.not_to change(Bandeira, :count)
      end
    end

  end

  describe "GET edit" do
    let(:bandeira) { FactoryGirl.create(:bandeira) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: bandeira }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o bandeira selecionado para @bandeira' do
      get :edit, xhr: true, params: { id: bandeira }
      expect(assigns(:bandeira)).to eq(bandeira)
    end

  end

  describe "PUT update" do
    let(:bandeira) { FactoryGirl.create(:bandeira) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:bandeira, sigla: "Novo nome", logo: '') }

      it 'renderiza Bandeira alterado' do
        put :update, xhr: true, params: { id: bandeira, bandeira: dados_validos, logo: '' }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o bandeira no banco de dados' do
        put :update, xhr: true, params: { id:bandeira, bandeira: dados_validos, logo: '' }
        bandeira.reload
        expect(bandeira.sigla).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:bandeira, nome: "", sigla: "XX", logo: '') }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: bandeira, bandeira: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o bandeira no banco de dados' do
        put :update, xhr: true, params: { id: bandeira, bandeira: dados_invalidos }
        bandeira.reload
        expect(bandeira.sigla).not_to eq("XX")
      end

    end
  end

  describe "DELETE destroy" do
    let(:bandeira) { FactoryGirl.create(:bandeira) }

    it 'deleta Bandeira da tabela' do
      delete :destroy, xhr: true, params: { id: bandeira }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta bandeira do banco de dados' do
      delete :destroy, xhr: true, params: { id: bandeira }
      expect(Bandeira.exists?(bandeira.id)).to be_falsy
    end

  end

end
