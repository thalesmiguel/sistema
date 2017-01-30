require 'rails_helper'

RSpec.describe Canal, type: :model do

  describe 'validações' do

    it 'exige nome' do
      canal = Canal.new(FactoryGirl.attributes_for(:canal, nome: ""))
      expect(canal.valid?).to be_falsy
    end

    it 'grava logo' do
      canal = FactoryGirl.create(:canal)
      expect(canal.logo_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:canal) { FactoryGirl.create(:canal) }

    it 'has_many :canal_leiloes, through LeilaoCanais' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_canal = FactoryGirl.create(:leilao_canal, canal: canal, leilao: primeiro_leilao)
      segundo_leilao_canal = FactoryGirl.create(:leilao_canal, canal: canal, leilao: segundo_leilao)
      expect(canal.canal_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:canal) { FactoryGirl.create(:canal) }

      it 'criação de Canal' do
        expect(canal.audits.count).to eq 1
      end

      it 'alteração de Canal' do
        novo_leilao = FactoryGirl.create(:leilao)
        canal.nome = "Novo Nome"
        canal.save
        expect(canal.audits.count).to eq 2
      end

      it 'exclusão de Canal' do
        canal.destroy
        expect(canal.audits.count).to eq 2
      end

    end
  end
end
