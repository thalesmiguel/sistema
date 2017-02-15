require 'rails_helper'

RSpec.describe LeiloeirosController, type: :controller do

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
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    it 'renderiza modal :new' do
      get :new, xhr: true, params: {}
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Leiloeiro para @leiloeiro' do
      get :new, xhr: true, params: {}
      expect(assigns(:leiloeiro)).to be_a_new(Leiloeiro)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :new, xhr: true, params: {}
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", estado)
      get :new, xhr: true, params: {}
      expect(assigns(:cidades)).to eq(cidades)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Leiloeiro' do
        post :create, xhr: true, params: { leiloeiro: FactoryGirl.attributes_for(:leiloeiro, foto: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo leiloeiro no banco de dados' do
        expect {
          post :create, xhr: true, params: { leiloeiro: FactoryGirl.attributes_for(:leiloeiro, foto: '') }
        }.to change(Leiloeiro, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { leiloeiro: FactoryGirl.attributes_for(:leiloeiro, foto: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo leiloeiro no banco de dados' do
        expect {
          post :create, xhr: true, params: { leiloeiro: FactoryGirl.attributes_for(:leiloeiro, razao_social: "", foto: '') }
        }.not_to change(Leiloeiro, :count)
      end
    end

  end

  describe "GET edit" do
    let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: leiloeiro }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o leiloeiro selecionado para @leiloeiro' do
      get :edit, xhr: true, params: { id: leiloeiro }
      expect(assigns(:leiloeiro)).to eq(leiloeiro)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :edit, xhr: true, params: { id: leiloeiro }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      leiloeiro = FactoryGirl.create(:leiloeiro, cidade: cidade)

      cidades = Cidade.where("estado_id = ?", leiloeiro.cidade.estado_id)
      get :edit, xhr: true, params: { id: leiloeiro }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "PUT update" do
    let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:leiloeiro, razao_social: "Novo razao_social", foto: '') }

      it 'renderiza Leiloeiro alterado' do
        put :update, xhr: true, params: { id: leiloeiro, leiloeiro: dados_validos, foto: '' }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o leiloeiro no banco de dados' do
        put :update, xhr: true, params: { id:leiloeiro, leiloeiro: dados_validos, foto: '' }
        leiloeiro.reload
        expect(leiloeiro.razao_social).to eq("Novo razao_social")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:leiloeiro, razao_social: "", foto: '') }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: leiloeiro, leiloeiro: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o leiloeiro no banco de dados' do
        put :update, xhr: true, params: { id: leiloeiro, leiloeiro: dados_invalidos }
        leiloeiro.reload
        expect(leiloeiro.razao_social).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }

    it 'deleta Leiloeiro da tabela' do
      delete :destroy, xhr: true, params: { id: leiloeiro }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta leiloeiro do banco de dados' do
      delete :destroy, xhr: true, params: { id: leiloeiro }
      expect(Leiloeiro.exists?(leiloeiro.id)).to be_falsy
    end

  end
end
