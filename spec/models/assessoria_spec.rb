require 'rails_helper'

RSpec.describe Assessoria, type: :model do

  describe 'validações' do

    it 'exige nome' do
      assessoria = Assessoria.new(FactoryGirl.attributes_for(:assessoria, nome: ""))
      expect(assessoria.valid?).to be_falsy
    end

    it 'grava logo' do
      bandeira = FactoryGirl.create(:assessoria)
      expect(bandeira.logo_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:assessoria) { FactoryGirl.create(:assessoria) }

    it 'has_many :assessoria_leiloes, through LeilaoCanais' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_assessoria = FactoryGirl.create(:leilao_assessoria, assessoria: assessoria, leilao: primeiro_leilao)
      segundo_leilao_assessoria = FactoryGirl.create(:leilao_assessoria, assessoria: assessoria, leilao: segundo_leilao)
      expect(assessoria.assessoria_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:assessoria) { FactoryGirl.create(:assessoria) }

      it 'criação de Assessoria' do
        expect(assessoria.audits.count).to eq 1
      end

      it 'alteração de Assessoria' do
        novo_leilao = FactoryGirl.create(:leilao)
        assessoria.nome = "Novo Nome"
        assessoria.save
        expect(assessoria.audits.count).to eq 2
      end

      it 'exclusão de Assessoria' do
        assessoria.destroy
        expect(assessoria.audits.count).to eq 2
      end

    end
  end
end
