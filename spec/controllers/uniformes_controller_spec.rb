require 'rails_helper'

RSpec.describe UniformesController, type: :controller do

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

    it 'atribui novo Uniforme para @uniforme' do
      get :new, xhr: true, params: {}
      expect(assigns(:uniforme)).to be_a_new(Uniforme)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Uniforme' do
        post :create, xhr: true, params: { uniforme: FactoryGirl.attributes_for(:uniforme) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo uniforme no banco de dados' do
        expect {
          post :create, xhr: true, params: { uniforme: FactoryGirl.attributes_for(:uniforme) }
        }.to change(Uniforme, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { uniforme: FactoryGirl.attributes_for(:uniforme, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo uniforme no banco de dados' do
        expect {
          post :create, xhr: true, params: { uniforme: FactoryGirl.attributes_for(:uniforme, nome: '') }
        }.not_to change(Uniforme, :count)
      end
    end

  end

  describe "GET edit" do
    let(:uniforme) { FactoryGirl.create(:uniforme) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: uniforme }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o uniforme selecionado para @uniforme' do
      get :edit, xhr: true, params: { id: uniforme }
      expect(assigns(:uniforme)).to eq(uniforme)
    end

  end

  describe "PUT update" do
    let(:uniforme) { FactoryGirl.create(:uniforme) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:uniforme, nome: "Novo nome") }

      it 'renderiza Uniforme alterado' do
        put :update, xhr: true, params: { id: uniforme, uniforme: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o uniforme no banco de dados' do
        put :update, xhr: true, params: { id:uniforme, uniforme: dados_validos }
        uniforme.reload
        expect(uniforme.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:uniforme, nome: "", sexo: "feminino") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: uniforme, uniforme: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o uniforme no banco de dados' do
        put :update, xhr: true, params: { id: uniforme, uniforme: dados_invalidos }
        uniforme.reload
        expect(uniforme.sexo).not_to eq("feminino")
      end

    end
  end

  describe "DELETE destroy" do
    let(:uniforme) { FactoryGirl.create(:uniforme) }

    it 'deleta Uniforme da tabela' do
      delete :destroy, xhr: true, params: { id: uniforme }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta uniforme do banco de dados' do
      delete :destroy, xhr: true, params: { id: uniforme }
      expect(Uniforme.exists?(uniforme.id)).to be_falsy
    end

  end

end
