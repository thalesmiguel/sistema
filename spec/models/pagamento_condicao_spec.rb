require 'rails_helper'

RSpec.describe PagamentoCondicao, type: :model do

  describe 'validações' do

    it 'exige codigo' do
      pagamento_condicao = PagamentoCondicao.new(FactoryGirl.attributes_for(:pagamento_condicao, codigo: ""))
      expect(pagamento_condicao.valid?).to be_falsy
    end

    it 'exige nome' do
      pagamento_condicao = PagamentoCondicao.new(FactoryGirl.attributes_for(:pagamento_condicao, nome: ""))
      expect(pagamento_condicao.valid?).to be_falsy
    end

    it 'exige tipo' do
      pagamento_condicao = PagamentoCondicao.new(FactoryGirl.attributes_for(:pagamento_condicao, tipo: ""))
      expect(pagamento_condicao.valid?).to be_falsy
    end

    it 'exige que o número de parcelas seja menor ou igual ao número de captações' do
      pagamento_condicao = PagamentoCondicao.new(FactoryGirl.attributes_for(:pagamento_condicao, parcelas: 10, captacoes: 8))
      expect(pagamento_condicao.valid?).to be_falsy
    end
  end

  describe 'associações' do
    # let(:leilao) { FactoryGirl.create(:leilao) }
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2) }

    it 'has_many PagamentoParcela' do
      primeira_pagamento_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
      segunda_pagamento_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
      expect(pagamento_condicao.pagamento_parcelas).to eq [primeira_pagamento_parcela, segunda_pagamento_parcela]
    end

    # it 'has_many :pagamento_condicao_leiloes, through LeilaoPagamentoCondicaos' do
    #   primeiro_leilao = FactoryGirl.create(:leilao)
    #   segundo_leilao = FactoryGirl.create(:leilao)
    #   primeiro_leilao_pagamento_condicao = FactoryGirl.create(:leilao_pagamento_condicao, pagamento_condicao: pagamento_condicao, leilao: primeiro_leilao)
    #   segundo_leilao_pagamento_condicao = FactoryGirl.create(:leilao_pagamento_condicao, pagamento_condicao: pagamento_condicao, leilao: segundo_leilao)
    #   expect(pagamento_condicao.pagamento_condicao_leiloes).to eq([primeiro_leilao, segundo_leilao])
    # end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao) }

      it 'criação de PagamentoCondicao' do
        expect(pagamento_condicao.audits.count).to eq 1
      end

      it 'alteração de PagamentoCondicao' do
        novo_leilao = FactoryGirl.create(:leilao)
        pagamento_condicao.nome = "Novo Nome"
        pagamento_condicao.save
        expect(pagamento_condicao.audits.count).to eq 2
      end

      it 'exclusão de PagamentoCondicao' do
        pagamento_condicao.destroy
        expect(pagamento_condicao.audits.count).to eq 2
      end

    end
  end
end
