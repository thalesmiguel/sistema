require 'rails_helper'

RSpec.describe Raca, type: :model do

  describe 'validações' do

    it 'exige codigo' do
      raca = Raca.new(FactoryGirl.attributes_for(:raca, codigo: ""))
      expect(raca.valid?).to be_falsy
    end

    it 'exige nome' do
      raca = Raca.new(FactoryGirl.attributes_for(:raca, nome: ""))
      expect(raca.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:raca) { FactoryGirl.create(:raca) }

    it 'has_many :raca_leiloes, through LeilaoCanais' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_raca = FactoryGirl.create(:leilao_raca, raca: raca, leilao: primeiro_leilao)
      segundo_leilao_raca = FactoryGirl.create(:leilao_raca, raca: raca, leilao: segundo_leilao)
      expect(raca.raca_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:raca) { FactoryGirl.create(:raca) }

      it 'criação de Raca' do
        expect(raca.audits.count).to eq 1
      end

      it 'alteração de Raca' do
        novo_leilao = FactoryGirl.create(:leilao)
        raca.nome = "Novo Nome"
        raca.save
        expect(raca.audits.count).to eq 2
      end

      it 'exclusão de Raca' do
        raca.destroy
        expect(raca.audits.count).to eq 2
      end

    end
  end
end
