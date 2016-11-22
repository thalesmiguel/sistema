require 'rails_helper'

RSpec.describe EstadosController, type: :controller do

  describe "GET index" do

    it 'renderiza template :index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renderiza json' do
      get :index, xhr: true, format: :json
      expect(response).to_not be_nil
    end

    it 'atribui todos os estados para @estados em ordem alfabética' do
      primeiro_estado = FactoryGirl.create(:estado, nome: 'Z')
      segundo_estado = FactoryGirl.create(:estado, nome: 'A')
      get :index
      expect(assigns(:estados)).to match([segundo_estado, primeiro_estado])
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: {}
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Estado para @estado' do
      get :new, xhr: true, params: {}
      expect(assigns(:estado)).to be_a_new(Estado)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Estado' do
        post :create, xhr: true, params: { estado: FactoryGirl.attributes_for(:estado) }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo estado no banco de dados' do
        expect {
          post :create, xhr: true, params: { estado: FactoryGirl.attributes_for(:estado) }
        }.to change(Estado, :count).by(1)
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
        }.not_to change(Estado, :count)
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

      it 'renderiza Estado alterado' do
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

    it 'deleta Estado da tabela' do
      delete :destroy, xhr: true, params: { id: estado }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta estado do banco de dados' do
      delete :destroy, xhr: true, params: { id: estado }
      expect(Estado.exists?(estado.id)).to be_falsy
    end

  end

end
