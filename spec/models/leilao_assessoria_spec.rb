require 'rails_helper'

RSpec.describe LeilaoAssessoria, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:assessoria) { FactoryGirl.create(:assessoria) }

    it 'exige assessoria' do
      leilao_assessoria = LeilaoAssessoria.new(FactoryGirl.attributes_for(:leilao_assessoria, assessoria: nil, leilao: leilao))
      expect(leilao_assessoria.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_assessoria = LeilaoAssessoria.new(FactoryGirl.attributes_for(:leilao_assessoria, assessoria: assessoria, leilao: nil))
      expect(leilao_assessoria.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:assessoria) { FactoryGirl.create(:assessoria) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_assessoria) { FactoryGirl.create(:leilao_assessoria, assessoria: assessoria, leilao: leilao) }

    it 'belongs_to Assessoria' do
      expect(leilao_assessoria.assessoria).to eq(assessoria)
    end

    it 'belongs_to Leilao' do
      expect(leilao_assessoria.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:assessoria) { FactoryGirl.create(:assessoria) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_assessoria) { FactoryGirl.create(:leilao_assessoria, assessoria: assessoria, leilao: leilao) }

      it 'criação de LeilaoAssessoria' do
        expect(leilao_assessoria.audits.count).to eq 1
      end

      it 'alteração de LeilaoAssessoria' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_assessoria.leilao = novo_leilao
        leilao_assessoria.save
        expect(leilao_assessoria.audits.count).to eq 2
      end

      it 'exclusão de LeilaoAssessoria' do
        leilao_assessoria.destroy
        expect(leilao_assessoria.audits.count).to eq 2
      end

    end
  end
end
