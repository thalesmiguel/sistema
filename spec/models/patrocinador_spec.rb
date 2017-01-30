require 'rails_helper'

RSpec.describe Patrocinador, type: :model do

  describe 'validações' do

    it 'exige nome' do
      patrocinador = Patrocinador.new(FactoryGirl.attributes_for(:patrocinador, nome: ""))
      expect(patrocinador.valid?).to be_falsy
    end

    it 'grava logo' do
      patrocinador = FactoryGirl.create(:patrocinador)
      expect(patrocinador.logo_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:patrocinador) { FactoryGirl.create(:patrocinador) }

    it 'has_many :patrocinador_leiloes, through LeilaoCanais' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_patrocinador = FactoryGirl.create(:leilao_patrocinador, patrocinador: patrocinador, leilao: primeiro_leilao)
      segundo_leilao_patrocinador = FactoryGirl.create(:leilao_patrocinador, patrocinador: patrocinador, leilao: segundo_leilao)
      expect(patrocinador.patrocinador_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:patrocinador) { FactoryGirl.create(:patrocinador) }

      it 'criação de Patrocinador' do
        expect(patrocinador.audits.count).to eq 1
      end

      it 'alteração de Patrocinador' do
        novo_leilao = FactoryGirl.create(:leilao)
        patrocinador.nome = "Novo Nome"
        patrocinador.save
        expect(patrocinador.audits.count).to eq 2
      end

      it 'exclusão de Patrocinador' do
        patrocinador.destroy
        expect(patrocinador.audits.count).to eq 2
      end

    end
  end
end
