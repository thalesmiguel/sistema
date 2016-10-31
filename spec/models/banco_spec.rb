require 'rails_helper'

RSpec.describe Banco, type: :model do
  describe 'validações' do

    it 'exige nome' do
      banco = Banco.new(FactoryGirl.attributes_for(:banco, nome: ''))
      expect(banco.valid?).to be_falsy
    end

    it 'exige que o código seja único' do
      primeiro_banco = FactoryGirl.create(:banco, codigo: "001")
      segundo_banco = Banco.new(FactoryGirl.attributes_for(:banco, codigo: "001"))
      expect(segundo_banco.valid?).to be_falsy
    end

  end

  describe 'associações' do

    it 'has_many ClienteBancos' do
      banco = FactoryGirl.create(:banco)
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      cliente = FactoryGirl.create(:cliente)
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = FactoryGirl.create(:cliente_banco, primario: false, banco: banco, cidade: cidade, cliente: cliente)
      expect(banco.cliente_bancos).to eq([primeiro_cliente_banco, segundo_cliente_banco])
    end
  end
end
