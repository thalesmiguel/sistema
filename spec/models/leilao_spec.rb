require 'rails_helper'

RSpec.describe Leilao, type: :model do

  describe 'validações' do
    it 'exige nome' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, nome: ""))
      expect(leilao.valid?).to be_falsy
    end

    it 'grava logo' do
      leilao = FactoryGirl.create(:leilao)
      expect(leilao.logo_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
    let(:user) { FactoryGirl.create(:user) }

    it 'belongs_to Cidade' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, cidade: cidade))
      expect(leilao.cidade).to eq(cidade)
    end

    it 'belongs_to User (testemunha_1)' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, testemunha_1: user))
      expect(leilao.testemunha_1).to eq(user)
    end

    it 'belongs_to User (testemunha_2)' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, testemunha_2: user))
      expect(leilao.testemunha_2).to eq(user)
    end
  end

  describe 'log' do

    describe 'gera log de' do

      it 'criação de Leilao' do
        leilao = FactoryGirl.create(:leilao)
        expect(leilao.audits.count).to eq 1
      end

      it 'alteração de Leilao' do
        leilao = FactoryGirl.create(:leilao)
        leilao.nome = "Novo nome"
        leilao.save
        expect(leilao.audits.count).to eq 2
      end

      it 'exclusão de Leilao' do
        leilao = FactoryGirl.create(:leilao)
        leilao.destroy
        expect(leilao.audits.count).to eq 2
      end

    end
  end
end
