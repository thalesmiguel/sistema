require 'rails_helper'

RSpec.describe CepsController, type: :controller do
  before(:each) do
    signed_in_as_a_valid_user
  end

  describe "GET busca" do
    it 'renderiza template :busca_cep' do
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      bairro = FactoryGirl.create(:bairro, cidade: cidade)
      logradouro = FactoryGirl.create(:logradouro, bairro: bairro, cep: 16020365)
      get :buscar, xhr: true, params: { cep: 16020365 }
      expect(response).to render_template('ajax/ceps/busca_cep.js.erb')
    end

    it 'atribui o cliente selecionada para @cliente' do
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      primeiro_bairro = FactoryGirl.create(:bairro, cidade: cidade)
      segundo_bairro = FactoryGirl.create(:bairro, cidade: cidade)
      primeiro_logradouro = FactoryGirl.create(:logradouro, bairro: primeiro_bairro, cep: '16020365')
      segundo_logradouro = FactoryGirl.create(:logradouro, bairro: segundo_bairro, cep: '16020363')
      get :buscar, xhr: true, params: { cep: 16020365 }
      expect(assigns(:logradouro)).to eq(primeiro_logradouro)
    end
  end
end
