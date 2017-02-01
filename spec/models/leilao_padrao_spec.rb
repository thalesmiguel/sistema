require 'rails_helper'

RSpec.describe LeilaoPadrao, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'exige leilao' do
      leilao_padrao = LeilaoPadrao.new(FactoryGirl.attributes_for(:leilao_padrao, leilao: nil))
      expect(leilao_padrao.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'belongs_to Leilao' do
      leilao_padrao = LeilaoPadrao.new(FactoryGirl.attributes_for(:leilao_padrao, leilao: leilao))
      expect(leilao_padrao.leilao).to eq(leilao)
    end

    it 'belongs_to :pagamento_elite pela classe PagamentoCondicao' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao)
      leilao_padrao = LeilaoPadrao.new(FactoryGirl.attributes_for(:leilao_padrao, leilao: leilao, pagamento_elite: pagamento_condicao))
      expect(leilao_padrao.pagamento_elite).to eq(pagamento_condicao)
    end

    it 'belongs_to :pagamento_elite pela classe PagamentoCondicao' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao)
      leilao_padrao = LeilaoPadrao.new(FactoryGirl.attributes_for(:leilao_padrao, leilao: leilao, pagamento_corte: pagamento_condicao))
      expect(leilao_padrao.pagamento_corte).to eq(pagamento_condicao)
    end

    it 'belongs_to :pagamento_elite pela classe PagamentoCondicao' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao)
      leilao_padrao = LeilaoPadrao.new(FactoryGirl.attributes_for(:leilao_padrao, leilao: leilao, pagamento_outros: pagamento_condicao))
      expect(leilao_padrao.pagamento_outros).to eq(pagamento_condicao)
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de LeilaoPadrao' do
        leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao)
        expect(leilao_padrao.audits.count).to eq 1
      end

      it 'alteração de LeilaoPadrao' do
        leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao)
        leilao_padrao.dolar = 1
        leilao_padrao.save
        expect(leilao_padrao.audits.count).to eq 2
      end

      it 'exclusão de LeilaoPadrao' do
        leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao)
        leilao_padrao.destroy
        expect(leilao_padrao.audits.count).to eq 2
      end

    end
  end
end
