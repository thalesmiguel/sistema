require 'rails_helper'

RSpec.describe LeilaoBandeira, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:bandeira) { FactoryGirl.create(:bandeira) }

    it 'exige bandeira' do
      leilao_bandeira = LeilaoBandeira.new(FactoryGirl.attributes_for(:leilao_bandeira, bandeira: nil, leilao: leilao))
      expect(leilao_bandeira.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_bandeira = LeilaoBandeira.new(FactoryGirl.attributes_for(:leilao_bandeira, bandeira: bandeira, leilao: nil))
      expect(leilao_bandeira.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:bandeira) { FactoryGirl.create(:bandeira) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_bandeira) { FactoryGirl.create(:leilao_bandeira, bandeira: bandeira, leilao: leilao) }

    it 'belongs_to Bandeira' do
      expect(leilao_bandeira.bandeira).to eq(bandeira)
    end

    it 'belongs_to Leilao' do
      expect(leilao_bandeira.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:bandeira) { FactoryGirl.create(:bandeira) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_bandeira) { FactoryGirl.create(:leilao_bandeira, bandeira: bandeira, leilao: leilao) }

      it 'criação de LeilaoBandeira' do
        expect(leilao_bandeira.audits.count).to eq 1
      end

      it 'alteração de LeilaoBandeira' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_bandeira.leilao = novo_leilao
        leilao_bandeira.save
        expect(leilao_bandeira.audits.count).to eq 2
      end

      it 'exclusão de LeilaoBandeira' do
        leilao_bandeira.destroy
        expect(leilao_bandeira.audits.count).to eq 2
      end

    end
  end
end
