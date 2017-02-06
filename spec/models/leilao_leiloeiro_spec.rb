require 'rails_helper'

RSpec.describe LeilaoLeiloeiro, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }

    it 'exige leilao' do
      leilao_leiloeiro = LeilaoLeiloeiro.new(FactoryGirl.attributes_for(:leilao_leiloeiro, leiloeiro: leiloeiro, leilao: nil))
      expect(leilao_leiloeiro.valid?).to be_falsy
    end

    it 'exige leiloeiro' do
      leilao_leiloeiro = LeilaoLeiloeiro.new(FactoryGirl.attributes_for(:leilao_leiloeiro, leiloeiro: nil, leilao: leilao))
      expect(leilao_leiloeiro.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_leiloeiro) { FactoryGirl.create(:leilao_leiloeiro, leiloeiro: leiloeiro, leilao: leilao) }

    it 'belongs_to Cliente' do
      expect(leilao_leiloeiro.leiloeiro).to eq(leiloeiro)
    end

    it 'belongs_to Leilao' do
      expect(leilao_leiloeiro.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_leiloeiro) { FactoryGirl.create(:leilao_leiloeiro, leiloeiro: leiloeiro, leilao: leilao) }

      it 'criação de LeilaoLeiloeiro' do
        expect(leilao_leiloeiro.audits.count).to eq 1
      end

      it 'alteração de LeilaoLeiloeiro' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_leiloeiro.leilao = novo_leilao
        leilao_leiloeiro.save
        expect(leilao_leiloeiro.audits.count).to eq 2
      end

      it 'exclusão de LeilaoLeiloeiro' do
        leilao_leiloeiro.destroy
        expect(leilao_leiloeiro.audits.count).to eq 2
      end

    end
  end
end
