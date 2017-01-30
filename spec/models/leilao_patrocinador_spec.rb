require 'rails_helper'

RSpec.describe LeilaoPatrocinador, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:patrocinador) { FactoryGirl.create(:patrocinador) }

    it 'exige patrocinador' do
      leilao_patrocinador = LeilaoPatrocinador.new(FactoryGirl.attributes_for(:leilao_patrocinador, patrocinador: nil, leilao: leilao))
      expect(leilao_patrocinador.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_patrocinador = LeilaoPatrocinador.new(FactoryGirl.attributes_for(:leilao_patrocinador, patrocinador: patrocinador, leilao: nil))
      expect(leilao_patrocinador.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:patrocinador) { FactoryGirl.create(:patrocinador) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_patrocinador) { FactoryGirl.create(:leilao_patrocinador, patrocinador: patrocinador, leilao: leilao) }

    it 'belongs_to Patrocinador' do
      expect(leilao_patrocinador.patrocinador).to eq(patrocinador)
    end

    it 'belongs_to Leilao' do
      expect(leilao_patrocinador.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:patrocinador) { FactoryGirl.create(:patrocinador) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_patrocinador) { FactoryGirl.create(:leilao_patrocinador, patrocinador: patrocinador, leilao: leilao) }

      it 'criação de LeilaoPatrocinador' do
        expect(leilao_patrocinador.audits.count).to eq 1
      end

      it 'alteração de LeilaoPatrocinador' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_patrocinador.leilao = novo_leilao
        leilao_patrocinador.save
        expect(leilao_patrocinador.audits.count).to eq 2
      end

      it 'exclusão de LeilaoPatrocinador' do
        leilao_patrocinador.destroy
        expect(leilao_patrocinador.audits.count).to eq 2
      end

    end
  end
end
