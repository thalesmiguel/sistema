require 'rails_helper'

RSpec.describe LeilaoCanal, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:canal) { FactoryGirl.create(:canal) }

    it 'exige canal' do
      leilao_canal = LeilaoCanal.new(FactoryGirl.attributes_for(:leilao_canal, canal: nil, leilao: leilao))
      expect(leilao_canal.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_canal = LeilaoCanal.new(FactoryGirl.attributes_for(:leilao_canal, canal: canal, leilao: nil))
      expect(leilao_canal.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:canal) { FactoryGirl.create(:canal) }
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:leilao_canal) { FactoryGirl.create(:leilao_canal, canal: canal, leilao: leilao) }

    it 'belongs_to Canal' do
      expect(leilao_canal.canal).to eq(canal)
    end

    it 'belongs_to Leilao' do
      expect(leilao_canal.leilao).to eq(leilao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:canal) { FactoryGirl.create(:canal) }
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:leilao_canal) { FactoryGirl.create(:leilao_canal, canal: canal, leilao: leilao) }

      it 'criação de LeilaoCanal' do
        expect(leilao_canal.audits.count).to eq 1
      end

      it 'alteração de LeilaoCanal' do
        novo_leilao = FactoryGirl.create(:leilao)
        leilao_canal.leilao = novo_leilao
        leilao_canal.save
        expect(leilao_canal.audits.count).to eq 2
      end

      it 'exclusão de LeilaoCanal' do
        leilao_canal.destroy
        expect(leilao_canal.audits.count).to eq 2
      end

    end
  end
end
