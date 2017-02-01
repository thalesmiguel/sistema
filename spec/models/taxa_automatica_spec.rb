require 'rails_helper'
require "money-rails/test_helpers"

RSpec.describe TaxaAutomatica, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'exige leilao' do
      taxa_automatica = TaxaAutomatica.new(FactoryGirl.attributes_for(:taxa_automatica, leilao: nil))
      expect(taxa_automatica.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'belongs_to Leilao' do
      taxa_automatica = TaxaAutomatica.new(FactoryGirl.attributes_for(:taxa_automatica, leilao: leilao))
      expect(taxa_automatica.leilao).to eq(leilao)
    end
  end

  describe 'métodos' do
    it 'apresenta valor com 4 casas decimais' do
      leilao = FactoryGirl.create(:leilao)
      taxa_automatica = TaxaAutomatica.new(FactoryGirl.attributes_for(:taxa_automatica, leilao: leilao, valor: 1.9999))
      is_expected.to monetize(:valor).with_currency(:brtx)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de TaxaAutomatica' do
        taxa_automatica = FactoryGirl.create(:taxa_automatica, leilao: leilao)
        expect(taxa_automatica.audits.count).to eq 1
      end

      it 'alteração de TaxaAutomatica' do
        taxa_automatica = FactoryGirl.create(:taxa_automatica, leilao: leilao)
        taxa_automatica.nome = 'Novo nome'
        taxa_automatica.save
        expect(taxa_automatica.audits.count).to eq 2
      end

      it 'exclusão de TaxaAutomatica' do
        taxa_automatica = FactoryGirl.create(:taxa_automatica, leilao: leilao)
        taxa_automatica.destroy
        expect(taxa_automatica.audits.count).to eq 2
      end

    end
  end
end
