require 'rails_helper'

RSpec.describe TaxaManual, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'exige leilao' do
      taxa_manual = TaxaManual.new(FactoryGirl.attributes_for(:taxa_manual, leilao: nil))
      expect(taxa_manual.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'belongs_to Leilao' do
      taxa_manual = TaxaManual.new(FactoryGirl.attributes_for(:taxa_manual, leilao: leilao))
      expect(taxa_manual.leilao).to eq(leilao)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de TaxaManual' do
        taxa_manual = FactoryGirl.create(:taxa_manual, leilao: leilao)
        expect(taxa_manual.audits.count).to eq 1
      end

      it 'alteração de TaxaManual' do
        taxa_manual = FactoryGirl.create(:taxa_manual, leilao: leilao)
        taxa_manual.nome = 'Novo nome'
        taxa_manual.save
        expect(taxa_manual.audits.count).to eq 2
      end

      it 'exclusão de TaxaManual' do
        taxa_manual = FactoryGirl.create(:taxa_manual, leilao: leilao)
        taxa_manual.destroy
        expect(taxa_manual.audits.count).to eq 2
      end

    end
  end
end
