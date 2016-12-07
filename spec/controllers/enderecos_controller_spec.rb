require 'rails_helper'

RSpec.describe EnderecosController, type: :controller do

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

    it 'atribui novo Endereco para @estado' do
      get :new, xhr: true, params: {}
      expect(assigns(:estado)).to be_a_new(Endereco)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Endereco' do
        post :create, xhr: true, params: { estado: FactoryGirl.attributes_for(:estado) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo estado no banco de dados' do
        expect {
          post :create, xhr: true, params: { estado: FactoryGirl.attributes_for(:estado) }
        }.to change(Endereco, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { estado: FactoryGirl.attributes_for(:estado, nome: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo estado no banco de dados' do
        expect {
          post :create, xhr: true, params: { estado: FactoryGirl.attributes_for(:estado, nome: '') }
        }.not_to change(Endereco, :count)
      end
    end

  end

  describe "GET edit" do
    let(:estado) { FactoryGirl.create(:estado) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: estado }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o estado selecionado para @estado' do
      get :edit, xhr: true, params: { id: estado }
      expect(assigns(:estado)).to eq(estado)
    end

  end

  describe "PUT update" do
    let(:estado) { FactoryGirl.create(:estado) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:estado, nome: "Novo nome") }

      it 'renderiza Endereco alterado' do
        put :update, xhr: true, params: { id: estado, estado: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o estado no banco de dados' do
        put :update, xhr: true, params: { id:estado, estado: dados_validos }
        estado.reload
        expect(estado.nome).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:estado, nome: "", sigla: "XX") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: estado, estado: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o estado no banco de dados' do
        put :update, xhr: true, params: { id: estado, estado: dados_invalidos }
        estado.reload
        expect(estado.sigla).not_to eq("XX")
      end

    end
  end

  describe "DELETE destroy" do
    let(:estado) { FactoryGirl.create(:estado) }

    it 'deleta Endereco da tabela' do
      delete :destroy, xhr: true, params: { id: estado }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta estado do banco de dados' do
      delete :destroy, xhr: true, params: { id: estado }
      expect(Endereco.exists?(estado.id)).to be_falsy
    end

  end

end
