require 'rails_helper'

RSpec.describe LeilaoConvidado, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:convidado) { FactoryGirl.create(:cliente) }

    it 'exige cliente' do
      leilao_convidado = LeilaoConvidado.new(FactoryGirl.attributes_for(:leilao_convidado, cliente: nil, leilao: leilao))
      expect(leilao_convidado.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_convidado = LeilaoConvidado.new(FactoryGirl.attributes_for(:leilao_convidado, cliente: convidado, leilao: nil))
      expect(leilao_convidado.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:convidado) { FactoryGirl.create(:cliente) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_convidado) { FactoryGirl.create(:leilao_convidado, cliente: convidado, leilao: leilao) }

    it 'belongs_to Cliente' do
      expect(leilao_convidado.cliente).to eq(convidado)
    end

    it 'belongs_to Leilao' do
      expect(leilao_convidado.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:convidado) { FactoryGirl.create(:cliente) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_convidado) { FactoryGirl.create(:leilao_convidado, cliente: convidado, leilao: leilao) }

      it 'criação de LeilaoConvidado' do
        expect(leilao_convidado.audits.count).to eq 1
      end

      it 'alteração de LeilaoConvidado' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_convidado.leilao = novo_leilao
        leilao_convidado.save
        expect(leilao_convidado.audits.count).to eq 2
      end

      it 'exclusão de LeilaoConvidado' do
        leilao_convidado.destroy
        expect(leilao_convidado.audits.count).to eq 2
      end

    end
  end
end
