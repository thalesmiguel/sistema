require 'rails_helper'

RSpec.describe PagamentoParcela, type: :model do

  describe 'validações' do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao) }

    it 'exige parcela' do
      pagamento_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: ""))
      expect(pagamento_parcela.valid?).to be_falsy
    end

    it 'exige captacoes' do
      pagamento_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao,  captacoes: ""))
      expect(pagamento_parcela.valid?).to be_falsy
    end

    it 'exige pagamento_condicao' do
      pagamento_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: nil))
      expect(pagamento_parcela.valid?).to be_falsy
    end

    it 'exige data de vencimento caso a condição de pagamento seja datas_diferenciadas' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2, tipo: 'datas_diferenciadas')
      pagamento_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1, vencimento: ''))
      expect(pagamento_parcela.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2) }

    it 'belongs_to PagamentoCondicao' do
      pagamento_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
      expect(pagamento_parcela.pagamento_condicao).to eq pagamento_condicao
    end

    # it 'has_many :pagamento_parcela_leiloes, through LeilaoPagamentoParcelas' do
    #   primeiro_leilao = FactoryGirl.create(:leilao)
    #   segundo_leilao = FactoryGirl.create(:leilao)
    #   primeiro_leilao_pagamento_parcela = FactoryGirl.create(:leilao_pagamento_parcela, pagamento_parcela: pagamento_parcela, leilao: primeiro_leilao)
    #   segundo_leilao_pagamento_parcela = FactoryGirl.create(:leilao_pagamento_parcela, pagamento_parcela: pagamento_parcela, leilao: segundo_leilao)
    #   expect(pagamento_parcela.pagamento_parcela_leiloes).to eq([primeiro_leilao, segundo_leilao])
    # end

  end

  describe 'métodos' do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 5, captacoes: 10) }

    it 'mostra a quantidade de captações atual' do
      primeira_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 2)
      segunda_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 2, captacoes: 2))
      expect(segunda_parcela.captacao_atual).to eq 2
    end

    it 'mostra que a quantidade de captações conferem' do
      primeira_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 2)
      segunda_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 2, captacoes: 2))
      expect(segunda_parcela.captacoes_conferem?).to be_falsey
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 1, captacoes: 1) }
      let(:pagamento_parcela) { FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1) }

      it 'criação de PagamentoParcela' do
        expect(pagamento_parcela.audits.count).to eq 1
      end

      it 'alteração de PagamentoParcela' do
        pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2)
        primeira_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
        segunda_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
        primeira_parcela.captacoes = 0
        primeira_parcela.save
        expect(primeira_parcela.audits.count).to eq 2
      end

      it 'exclusão de PagamentoParcela' do
        pagamento_parcela.destroy
        expect(pagamento_parcela.audits.count).to eq 2
      end

    end
  end
end
