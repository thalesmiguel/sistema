require 'rails_helper'

RSpec.describe LeilaoEvento, type: :model do

  describe 'validações' do
    it 'exige nome' do
      leilao_evento = LeilaoEvento.new(FactoryGirl.attributes_for(:leilao_evento, nome: ""))
      expect(leilao_evento.valid?).to be_falsy
    end
  end

  describe 'associações' do
    it 'has_many Leilões' do
      leilao_evento = FactoryGirl.create(:leilao_evento)
      primeiro_leilao = FactoryGirl.create(:leilao, leilao_evento: leilao_evento)
      segundo_leilao = FactoryGirl.create(:leilao, leilao_evento: leilao_evento)
      expect(leilao_evento.leiloes).to eq [primeiro_leilao, segundo_leilao]
    end
  end

  describe 'log' do

    describe 'gera log de' do
      it 'criação de LeilaoEvento' do
        leilao_evento = FactoryGirl.create(:leilao_evento)
        expect(leilao_evento.audits.count).to eq 1
      end

      it 'alteração de LeilaoEvento' do
        leilao_evento = FactoryGirl.create(:leilao_evento)
        leilao_evento.nome = "Novo nome"
        leilao_evento.save
        expect(leilao_evento.audits.count).to eq 2
      end

      it 'exclusão de LeilaoEvento' do
        leilao_evento = FactoryGirl.create(:leilao_evento)
        leilao_evento.destroy
        expect(leilao_evento.audits.count).to eq 2
      end

    end
  end
end
