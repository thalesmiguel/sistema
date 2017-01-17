require 'rails_helper'

RSpec.describe AlertaComentariosController, type: :controller do

  before(:each) do
    signed_in_as_a_valid_user
  end

  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:user) { FactoryGirl.create(:user) }
  let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user: user) }

  describe "GET index" do
    it 'renderiza template :index' do
      get :index, xhr: true, params: { alerta_id: alerta.id }
      expect(response).to render_template('ajax/clientes/alertas/alerta_comentarios/index.js.erb')
    end

    it 'renderiza json' do
      get :index, xhr: true, format: :json, params: { alerta_id: alerta.id }
      expect(response).to_not be_nil
    end

  end

  describe "GET new" do

    it 'renderiza modal :new' do
      get :new, xhr: true, params: { alerta_id: alerta.id }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui novo AlertaComentario para @alerta_comentario' do
      get :new, xhr: true, params: { alerta_id: alerta.id }
      expect(assigns(:alerta_comentario)).to be_a_new(AlertaComentario)
    end

  end

  describe "POST create" do

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:alerta_comentario, alerta_id: alerta) }

      it 'renderiza novo AlertaComentario' do
        post :create, xhr: true, params: { alerta_id: alerta.id, alerta_comentario: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo alerta_comentario no banco de dados' do
        expect {
          post :create, xhr: true, params: { alerta_id: alerta.id, alerta_comentario: dados_validos }
        }.to change(AlertaComentario, :count).by(1)

      end

    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:alerta_comentario, alerta_id: alerta, descricao: '') }

      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { alerta_id: alerta.id, alerta_comentario: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo alerta_comentario no banco de dados' do
        expect {
          post :create, xhr: true, params: { alerta_id: alerta.id, alerta_comentario: dados_invalidos }
        }.not_to change(AlertaComentario, :count)
      end
    end

  end

  describe "GET edit" do
    let(:alerta_comentario) { FactoryGirl.create(:alerta_comentario, alerta: alerta) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o alerta_comentario selecionado para @alerta_comentario' do
      get :edit, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario }
      expect(assigns(:alerta_comentario)).to eq(alerta_comentario)
    end

  end

  describe "PUT update" do
    let(:alerta_comentario) { FactoryGirl.create(:alerta_comentario, alerta: alerta) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:alerta_comentario, alerta_id: alerta, descricao: "asdf asdf asdf") }

      it 'renderiza AlertaComentario alterado' do
        put :update, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario, alerta_comentario: dados_validos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o alerta_comentario no banco de dados' do
        put :update, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario, alerta_comentario: dados_validos }
        alerta_comentario.reload
        expect(alerta_comentario.descricao).to eq("asdf asdf asdf")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:alerta_comentario, alerta_id: alerta, descricao: "") }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario, alerta_comentario: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o alerta_comentario no banco de dados' do
        put :update, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario, alerta_comentario: dados_invalidos }
        alerta_comentario.reload
        expect(alerta_comentario.descricao).not_to eq("")
      end

    end
  end

  describe "DELETE destroy" do
    let(:alerta_comentario) { FactoryGirl.create(:alerta_comentario, alerta: alerta) }

    it 'deleta AlertaComentario da tabela' do
      delete :destroy, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta alerta_comentario do banco de dados' do
      delete :destroy, xhr: true, params: { alerta_id: alerta.id, id: alerta_comentario }
      expect(AlertaComentario.exists?(alerta_comentario.id)).to be_falsy
    end
  end

end
