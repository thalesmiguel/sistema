require 'rails_helper'

RSpec.describe LeilaoPromotor, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:promotor) { FactoryGirl.create(:cliente) }

    it 'exige cliente' do
      leilao_promotor = LeilaoPromotor.new(FactoryGirl.attributes_for(:leilao_promotor, cliente: nil, leilao: leilao))
      expect(leilao_promotor.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_promotor = LeilaoPromotor.new(FactoryGirl.attributes_for(:leilao_promotor, cliente: promotor, leilao: nil))
      expect(leilao_promotor.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:promotor) { FactoryGirl.create(:cliente) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_promotor) { FactoryGirl.create(:leilao_promotor, cliente: promotor, leilao: leilao) }

    it 'belongs_to Cliente' do
      expect(leilao_promotor.cliente).to eq(promotor)
    end

    it 'belongs_to Leilao' do
      expect(leilao_promotor.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:promotor) { FactoryGirl.create(:cliente) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_promotor) { FactoryGirl.create(:leilao_promotor, cliente: promotor, leilao: leilao) }

      it 'criação de LeilaoPromotor' do
        expect(leilao_promotor.audits.count).to eq 1
      end

      it 'alteração de LeilaoPromotor' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_promotor.leilao = novo_leilao
        leilao_promotor.save
        expect(leilao_promotor.audits.count).to eq 2
      end

      it 'exclusão de LeilaoPromotor' do
        leilao_promotor.destroy
        expect(leilao_promotor.audits.count).to eq 2
      end

    end
  end
end
