require 'rails_helper'

RSpec.describe Bandeira, type: :model do

  describe 'validações' do

    it 'exige nome' do
      bandeira = Bandeira.new(FactoryGirl.attributes_for(:bandeira, nome: ""))
      expect(bandeira.valid?).to be_falsy
    end

    it 'grava logo' do
      bandeira = FactoryGirl.create(:bandeira)
      expect(bandeira.logo_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:bandeira) { FactoryGirl.create(:bandeira) }

    it 'has_many :bandeira_leiloes, through LeilaoBandeiras' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: bandeira, leilao: primeiro_leilao)
      segundo_leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: bandeira, leilao: segundo_leilao)
      expect(bandeira.bandeira_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:bandeira) { FactoryGirl.create(:bandeira) }

      it 'criação de Bandeira' do
        expect(bandeira.audits.count).to eq 1
      end

      it 'alteração de Bandeira' do
        novo_leilao = FactoryGirl.create(:leilao)
        bandeira.nome = "Novo Nome"
        bandeira.save
        expect(bandeira.audits.count).to eq 2
      end

      it 'exclusão de Bandeira' do
        bandeira.destroy
        expect(bandeira.audits.count).to eq 2
      end

    end
  end
end
