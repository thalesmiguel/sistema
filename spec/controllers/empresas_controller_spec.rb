require 'rails_helper'

RSpec.describe EmpresasController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/clientes/empresas/index.js.erb')
    end

    # it 'renderiza json' do
    #   get :index, xhr: true, format: :json, params: { cliente_id: cliente.id }
    #   expect(response).to_not be_nil
    # end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo Empresa para @empresa' do
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:empresa)).to be_a_new(Empresa)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", estado)
      get :new, xhr: true, params: { cliente_id: cliente.id }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:empresa, cidade_id: cidade, cliente_id: cliente) }

      it 'renderiza novo Empresa' do
        post :create, xhr: true, params: { cliente_id: cliente.id, empresa: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo empresa no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, empresa: dados_validos }
        }.to change(Empresa, :count).by(1)
      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:empresa, cidade_id: cidade, cliente_id: cliente, nome: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { cliente_id: cliente.id, empresa: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo empresa no banco de dados' do
        expect {
          post :create, xhr: true, params: { cliente_id: cliente.id, empresa: dados_invalidos }
        }.not_to change(Empresa, :count)
      end
    end

  end

  describe "GET edit" do
    let(:empresa) { FactoryGirl.create(:empresa, cliente: cliente, cidade: cidade) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: empresa }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o empresa selecionado para @empresa' do
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: empresa }
      expect(assigns(:empresa)).to eq(empresa)
    end

    it 'atribui todos os estados para @estados' do
      estados = Estado.all
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: empresa }
      expect(assigns(:estados)).to eq(estados)
    end

    it 'atribui cidades do estado atual para @cidades' do
      cidades = Cidade.where("estado_id = ?", empresa.cidade.estado_id)
      get :edit, xhr: true, params: { cliente_id: cliente.id, id: empresa }
      expect(assigns(:cidades)).to eq(cidades)
    end

  end

  describe "PUT update" do
    let(:empresa) { FactoryGirl.create(:empresa, cliente: cliente, cidade: cidade) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:empresa, cidade_id: cidade, cliente_id: cliente, nome: "Novo Nome") }

      it 'renderiza Empresa alterado' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: empresa, empresa: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o empresa no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: empresa, empresa: dados_validos }
        empresa.reload
        expect(empresa.nome).to eq("Novo Nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:empresa, cidade_id: cidade, cliente_id: cliente, nome: "", numero: "222") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: empresa, empresa: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o empresa no banco de dados' do
        put :update, xhr: true, params: { cliente_id: cliente.id, id: empresa, empresa: dados_invalidos }
        empresa.reload
        expect(empresa.numero).not_to eq("222")
      end

    end
  end

  describe "DELETE destroy" do
    let(:empresa) { FactoryGirl.create(:empresa, cliente: cliente, cidade: cidade) }

    it 'deleta Empresa da tabela' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: empresa }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta empresa do banco de dados' do
      delete :destroy, xhr: true, params: { cliente_id: cliente.id, id: empresa }
      expect(Empresa.exists?(empresa.id)).to be_falsy
    end
  end

end
