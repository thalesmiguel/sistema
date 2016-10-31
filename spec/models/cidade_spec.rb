require 'rails_helper'

RSpec.describe Cidade, type: :model do

  describe 'validações' do

    it 'exige nome' do
      estado = FactoryGirl.create(:estado)
      cidade = Cidade.new(FactoryGirl.attributes_for(:cidade, nome: '', estado: estado))
      expect(cidade.valid?).to be_falsy
    end

    it 'é única por estado' do
      estado = FactoryGirl.create(:estado)
      primeira_cidade = FactoryGirl.create(:cidade, nome: 'Araçatuba', estado: estado)
      segunda_cidade = Cidade.new(nome: 'Araçatuba', estado: estado)
      expect(segunda_cidade.valid?).to be_falsy
    end
  end

  describe 'associações' do

    it 'belongs_to Estado' do
      cidade = Cidade.new(FactoryGirl.attributes_for(:cidade, estado: nil))
      expect(cidade.valid?).to be_falsy
    end

    it 'has_many Endereços' do
      estado = FactoryGirl.create(:estado)
      cidade = Cidade.new(FactoryGirl.attributes_for(:cidade, estado: estado))
      cliente = FactoryGirl.create(:cliente)
      primeiro_endereco = FactoryGirl.create(:endereco, cidade: cidade, cliente: cliente)
      segundo_endereco = FactoryGirl.create(:endereco, primario: false, cidade: cidade, cliente: cliente)
      expect(cidade.enderecos).to eq([primeiro_endereco, segundo_endereco])
    end

    it 'has_many Fazendas' do
      estado = FactoryGirl.create(:estado)
      cidade = Cidade.new(FactoryGirl.attributes_for(:cidade, estado: estado))
      cliente = FactoryGirl.create(:cliente)
      primeira_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      segunda_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      expect(cidade.fazendas).to eq([primeira_fazenda, segunda_fazenda])
    end
  end
end
