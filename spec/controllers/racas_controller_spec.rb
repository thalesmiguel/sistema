require 'rails_helper'

RSpec.describe RacasController, type: :controller do

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

    it 'atribui novo Raca para @raca' do
      get :new, xhr: true, params: {}
      expect(assigns(:raca)).to be_a_new(Raca)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Raca' do
        post :create, xhr: true, params: { raca: FactoryGirl.attributes_for(:raca) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo raca no banco de dados' do
        expect {
          post :create, xhr: true, params: { raca: FactoryGirl.attributes_for(:raca) }
        }.to change(Raca, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { raca: FactoryGirl.attributes_for(:raca, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo raca no banco de dados' do
        expect {
          post :create, xhr: true, params: { raca: FactoryGirl.attributes_for(:raca, nome: '') }
        }.not_to change(Raca, :count)
      end
    end

  end

  describe "GET edit" do
    let(:raca) { FactoryGirl.create(:raca) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: raca }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o raca selecionado para @raca' do
      get :edit, xhr: true, params: { id: raca }
      expect(assigns(:raca)).to eq(raca)
    end

  end

  describe "PUT update" do
    let(:raca) { FactoryGirl.create(:raca) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:raca, nome: "Novo nome") }

      it 'renderiza Raca alterado' do
        put :update, xhr: true, params: { id: raca, raca: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o raca no banco de dados' do
        put :update, xhr: true, params: { id: raca, raca: dados_validos }
        raca.reload
        expect(raca.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:raca, nome: "", especie: "ovino") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: raca, raca: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o raca no banco de dados' do
        put :update, xhr: true, params: { id: raca, raca: dados_invalidos }
        raca.reload
        expect(raca.especie).not_to eq("ovino")
      end

    end
  end

  describe "DELETE destroy" do
    let(:raca) { FactoryGirl.create(:raca) }

    it 'deleta Raca da tabela' do
      delete :destroy, xhr: true, params: { id: raca }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta raca do banco de dados' do
      delete :destroy, xhr: true, params: { id: raca }
      expect(Raca.exists?(raca.id)).to be_falsy
    end

  end

end
