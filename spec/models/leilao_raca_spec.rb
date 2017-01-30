require 'rails_helper'

RSpec.describe LeilaoRaca, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:raca) { FactoryGirl.create(:raca) }

    it 'exige raca' do
      leilao_raca = LeilaoRaca.new(FactoryGirl.attributes_for(:leilao_raca, raca: nil, leilao: leilao))
      expect(leilao_raca.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_raca = LeilaoRaca.new(FactoryGirl.attributes_for(:leilao_raca, raca: raca, leilao: nil))
      expect(leilao_raca.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:raca) { FactoryGirl.create(:raca) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_raca) { FactoryGirl.create(:leilao_raca, raca: raca, leilao: leilao) }

    it 'belongs_to Raca' do
      expect(leilao_raca.raca).to eq(raca)
    end

    it 'belongs_to Leilao' do
      expect(leilao_raca.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:raca) { FactoryGirl.create(:raca) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_raca) { FactoryGirl.create(:leilao_raca, raca: raca, leilao: leilao) }

      it 'criação de LeilaoRaca' do
        expect(leilao_raca.audits.count).to eq 1
      end

      it 'alteração de LeilaoRaca' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_raca.leilao = novo_leilao
        leilao_raca.save
        expect(leilao_raca.audits.count).to eq 2
      end

      it 'exclusão de LeilaoRaca' do
        leilao_raca.destroy
        expect(leilao_raca.audits.count).to eq 2
      end

    end
  end
end
