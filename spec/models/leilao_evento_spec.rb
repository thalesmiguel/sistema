require 'rails_helper'

RSpec.describe LeilaoEvento, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'exige descricao' do
      leilao_evento = LeilaoEvento.new(FactoryGirl.attributes_for(:leilao_evento, descricao: "", leilao: leilao))
      expect(leilao_evento.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_evento = LeilaoEvento.new(FactoryGirl.attributes_for(:leilao_evento, leilao: nil))
      expect(leilao_evento.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'belongs_to Leilao' do
      leilao_evento = LeilaoEvento.new(FactoryGirl.attributes_for(:leilao_evento, leilao: leilao))
      expect(leilao_evento.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de LeilaoEvento' do
        leilao_evento = FactoryGirl.create(:leilao_evento, leilao: leilao)
        expect(leilao_evento.audits.count).to eq 1
      end

      it 'alteração de LeilaoEvento' do
        leilao_evento = FactoryGirl.create(:leilao_evento, leilao: leilao)
        leilao_evento.descricao = "Novo nome"
        leilao_evento.save
        expect(leilao_evento.audits.count).to eq 2
      end

      it 'exclusão de LeilaoEvento' do
        leilao_evento = FactoryGirl.create(:leilao_evento, leilao: leilao)
        leilao_evento.destroy
        expect(leilao_evento.audits.count).to eq 2
      end

    end
  end
end
