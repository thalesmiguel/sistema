require 'rails_helper'

RSpec.describe LeilaoComissao, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'exige leilao' do
      leilao_comissao = LeilaoComissao.new(FactoryGirl.attributes_for(:leilao_comissao, leilao: nil))
      expect(leilao_comissao.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'belongs_to Leilao' do
      leilao_comissao = LeilaoComissao.new(FactoryGirl.attributes_for(:leilao_comissao, leilao: leilao))
      expect(leilao_comissao.leilao).to eq(leilao)
    end

    it 'belongs_to :banco_promotor pelo modelo ClienteBanco' do
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      cliente = FactoryGirl.create(:cliente)
      banco = FactoryGirl.create(:banco)

      cliente_banco = FactoryGirl.create(:cliente_banco, cliente: cliente, banco: banco, cidade: cidade)
      leilao_comissao = LeilaoComissao.new(FactoryGirl.attributes_for(:leilao_comissao, leilao: leilao, promotor_banco: cliente_banco))
      expect(leilao_comissao.promotor_banco).to eq(cliente_banco)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de LeilaoComissao' do
        leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao)
        expect(leilao_comissao.audits.count).to eq 1
      end

      it 'alteração de LeilaoComissao' do
        leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao)
        leilao_comissao.valor_fixo_venda = 1
        leilao_comissao.save
        expect(leilao_comissao.audits.count).to eq 2
      end

      it 'exclusão de LeilaoComissao' do
        leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao)
        leilao_comissao.destroy
        expect(leilao_comissao.audits.count).to eq 2
      end

    end
  end
end
