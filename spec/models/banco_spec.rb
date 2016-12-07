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

  describe 'log' do

    describe 'gera log de' do
      let(:banco) { FactoryGirl.create(:banco) }

      it 'criação de Telefone' do
        expect(banco.audits.count).to eq 1
      end

      it 'alteração de Telefone' do
        banco.codigo = "Novo código"
        banco.save
        expect(banco.audits.count).to eq 2
      end

      it 'exclusão de Telefone' do
        banco.destroy
        expect(banco.audits.count).to eq 2
      end

    end
  end

end
