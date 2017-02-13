require 'rails_helper'

RSpec.describe CanaisController, type: :controller do

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

    it 'atribui novo Canal para @canal' do
      get :new, xhr: true, params: {}
      expect(assigns(:canal)).to be_a_new(Canal)
    end
  end

  describe "POST create" do

    context 'dados válidos' do
      it 'renderiza novo Canal' do
        post :create, xhr: true, params: { canal: FactoryGirl.attributes_for(:canal, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'cria novo canal no banco de dados' do
        expect {
          post :create, xhr: true, params: { canal: FactoryGirl.attributes_for(:canal, logo: '') }
        }.to change(Canal, :count).by(1)
      end

    end

    context 'dados inválidos' do
      it 'renderiza mensagem de erro' do
        post :create, xhr: true, params: { canal: FactoryGirl.attributes_for(:canal, logo: '') }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não cria novo canal no banco de dados' do
        expect {
          post :create, xhr: true, params: { canal: FactoryGirl.attributes_for(:canal, nome: "", logo: '') }
        }.not_to change(Canal, :count)
      end
    end

  end

  describe "GET edit" do
    let(:canal) { FactoryGirl.create(:canal) }

    it 'renderiza modal :edit' do
      get :edit, xhr: true, params: { id: canal }
      expect(response).to render_template('ajax/application/mostra_modal.js.erb')
    end

    it 'atribui o canal selecionado para @canal' do
      get :edit, xhr: true, params: { id: canal }
      expect(assigns(:canal)).to eq(canal)
    end

  end

  describe "PUT update" do
    let(:canal) { FactoryGirl.create(:canal) }

    context 'dados válidos' do
      let(:dados_validos) { FactoryGirl.attributes_for(:canal, observacao: "Novo nome", logo: '') }

      it 'renderiza Canal alterado' do
        put :update, xhr: true, params: { id: canal, canal: dados_validos, logo: '' }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'altera o canal no banco de dados' do
        put :update, xhr: true, params: { id:canal, canal: dados_validos, logo: '' }
        canal.reload
        expect(canal.observacao).to eq("Novo nome")
      end
    end

    context 'dados inválidos' do
      let(:dados_invalidos) { FactoryGirl.attributes_for(:canal, nome: "", observacao: "XX", logo: '') }

      it 'renderiza mensagem de erro' do
        put :update, xhr: true, params: { id: canal, canal: dados_invalidos }
        expect(response).to render_template("ajax/application/crud.js.erb")
      end

      it 'não altera o canal no banco de dados' do
        put :update, xhr: true, params: { id: canal, canal: dados_invalidos }
        canal.reload
        expect(canal.observacao).not_to eq("XX")
      end

    end
  end

  describe "DELETE destroy" do
    let(:canal) { FactoryGirl.create(:canal) }

    it 'deleta Canal da tabela' do
      delete :destroy, xhr: true, params: { id: canal }
      expect(response).to render_template("ajax/application/crud.js.erb")
    end

    it 'deleta canal do banco de dados' do
      delete :destroy, xhr: true, params: { id: canal }
      expect(Canal.exists?(canal.id)).to be_falsy
    end

  end

end
