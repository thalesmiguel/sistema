require 'rails_helper'

RSpec.describe Leiloeiro, type: :model do

  describe 'validações' do
    it 'exige razao_social' do
      leiloeiro = Leiloeiro.new(FactoryGirl.attributes_for(:leiloeiro, razao_social: ""))
      expect(leiloeiro.valid?).to be_falsy
    end

    it 'exige que sigla tenha 2 caracteres' do
      leiloeiro = Leiloeiro.new(FactoryGirl.attributes_for(:leiloeiro, sigla: "ABC"))
      expect(leiloeiro.valid?).to be_falsy
    end

    it 'grava logo' do
      bandeira = FactoryGirl.create(:leiloeiro)
      expect(bandeira.foto_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
    let(:cliente) { FactoryGirl.create(:cliente) }
    let(:leiloeiro) { FactoryGirl.create(:leiloeiro, cidade: cidade, cliente: cliente) }

    it 'belongs_to Cidade' do
      expect(leiloeiro.cidade).to eq cidade
    end

    it 'belongs_to Cliente' do
      expect(leiloeiro.cliente).to eq cliente
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:leiloeiro) { FactoryGirl.create(:leiloeiro) }

      it 'criação de Leiloeiro' do
        expect(leiloeiro.audits.count).to eq 1
      end

      it 'alteração de Leiloeiro' do
        novo_leilao = FactoryGirl.create(:leilao)
        leiloeiro.nome_contrato = "Novo Nome"
        leiloeiro.save
        expect(leiloeiro.audits.count).to eq 2
      end

      it 'exclusão de Leiloeiro' do
        leiloeiro.destroy
        expect(leiloeiro.audits.count).to eq 2
      end
    end
  end
end
