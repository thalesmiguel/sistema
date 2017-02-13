require 'rails_helper'

RSpec.describe VeiculosController, type: :controller do

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

    it 'atribui novo Veiculo para @veiculo' do
      get :new, xhr: true, params: {}
      expect(assigns(:veiculo)).to be_a_new(Veiculo)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Veiculo' do
        post :create, xhr: true, params: { veiculo: FactoryGirl.attributes_for(:veiculo) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo veiculo no banco de dados' do
        expect {
          post :create, xhr: true, params: { veiculo: FactoryGirl.attributes_for(:veiculo) }
        }.to change(Veiculo, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { veiculo: FactoryGirl.attributes_for(:veiculo, modelo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo veiculo no banco de dados' do
        expect {
          post :create, xhr: true, params: { veiculo: FactoryGirl.attributes_for(:veiculo, modelo: '') }
        }.not_to change(Veiculo, :count)
      end
    end

  end

  describe "GET edit" do
    let(:veiculo) { FactoryGirl.create(:veiculo) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: veiculo }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o veiculo selecionado para @veiculo' do
      get :edit, xhr: true, params: { id: veiculo }
      expect(assigns(:veiculo)).to eq(veiculo)
    end

  end

  describe "PUT update" do
    let(:veiculo) { FactoryGirl.create(:veiculo) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:veiculo, chassi: "Novo nome") }

      it 'renderiza Veiculo alterado' do
        put :update, xhr: true, params: { id: veiculo, veiculo: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o veiculo no banco de dados' do
        put :update, xhr: true, params: { id:veiculo, veiculo: dados_validos }
        veiculo.reload
        expect(veiculo.chassi).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:veiculo, modelo: "", chassi: "XX") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: veiculo, veiculo: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o veiculo no banco de dados' do
        put :update, xhr: true, params: { id: veiculo, veiculo: dados_invalidos }
        veiculo.reload
        expect(veiculo.chassi).not_to eq("XX")
      end

    end
  end

  describe "DELETE destroy" do
    let(:veiculo) { FactoryGirl.create(:veiculo) }

    it 'deleta Veiculo da tabela' do
      delete :destroy, xhr: true, params: { id: veiculo }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta veiculo do banco de dados' do
      delete :destroy, xhr: true, params: { id: veiculo }
      expect(Veiculo.exists?(veiculo.id)).to be_falsy
    end

  end

end
