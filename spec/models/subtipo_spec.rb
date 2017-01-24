require 'rails_helper'

RSpec.describe Subtipo, type: :model do

  describe 'validações' do

    it 'exige codigo' do
      subtipo = Subtipo.new(FactoryGirl.attributes_for(:subtipo, codigo: ''))
      expect(subtipo.valid?).to be_falsy
    end

    it 'exige nome' do
      subtipo = Subtipo.new(FactoryGirl.attributes_for(:subtipo, nome: ''))
      expect(subtipo.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'has_many Leiloes' do
      subtipo = FactoryGirl.create(:subtipo)
      primeiro_leilao = FactoryGirl.create(:leilao, subtipo_lotes: subtipo)
      segundo_leilao = FactoryGirl.create(:leilao, subtipo_lotes: subtipo)
      expect(subtipo.leiloes).to eq([primeiro_leilao, segundo_leilao])
    end

  end

  describe 'log' do

    describe 'gera log de' do

      it 'criação de Subtipo' do
        subtipo = FactoryGirl.create(:subtipo)
        expect(subtipo.audits.count).to eq 1
      end

      it 'alteração de Subtipo' do
        subtipo = FactoryGirl.create(:subtipo)
        subtipo.nome = "Novo nome"
        subtipo.save
        expect(subtipo.audits.count).to eq 2
      end

      it 'exclusão de Subtipo' do
        subtipo = FactoryGirl.create(:subtipo)
        subtipo.destroy
        expect(subtipo.audits.count).to eq 2
      end

    end
  end
end
