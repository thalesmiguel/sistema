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

    context 'valida a última parcela' do
      it 'Criando: exige que a soma das captações seja igual a quantidade de captações de PagamentoParcela' do
        pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 10)
        primeira_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 5)
        ultima_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 2, captacoes: 4))
        expect(ultima_parcela.valid?).to be_falsy
      end

      it 'Editando: exige que a soma das captações seja igual a quantidade de captações de PagamentoParcela' do
        pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 10)
        primeira_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 5)
        ultima_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 2, captacoes: 5)
        ultima_parcela.captacoes = 4
        ultima_parcela.captacoes = 5
        ultima_parcela.valid?
        expect(ultima_parcela.valid?).to be_truthy
      end
    end
  end

  describe 'associações' do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2) }

    it 'has_many PagamentoParcela' do
      primeira_pagamento_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
      segunda_pagamento_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 2, captacoes: 1)
      expect(pagamento_condicao.pagamento_parcelas).to eq [primeira_pagamento_parcela, segunda_pagamento_parcela]
    end

    # it 'has_many :pagamento_parcela_leiloes, through LeilaoPagamentoParcelas' do
    #   primeiro_leilao = FactoryGirl.create(:leilao)
    #   segundo_leilao = FactoryGirl.create(:leilao)
    #   primeiro_leilao_pagamento_parcela = FactoryGirl.create(:leilao_pagamento_parcela, pagamento_parcela: pagamento_parcela, leilao: primeiro_leilao)
    #   segundo_leilao_pagamento_parcela = FactoryGirl.create(:leilao_pagamento_parcela, pagamento_parcela: pagamento_parcela, leilao: segundo_leilao)
    #   expect(pagamento_parcela.pagamento_parcela_leiloes).to eq([primeiro_leilao, segundo_leilao])
    # end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 1, captacoes: 1) }
      let(:pagamento_parcela) { FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1) }

      it 'criação de PagamentoParcela' do
        expect(pagamento_parcela.audits.count).to eq 1
      end

      it 'alteração de PagamentoParcela' do
        novo_leilao = FactoryGirl.create(:leilao)
        pagamento_parcela.captacoes = 0
        pagamento_parcela.save
        expect(pagamento_parcela.audits.count).to eq 2
      end

      it 'exclusão de PagamentoParcela' do
        pagamento_parcela.destroy
        expect(pagamento_parcela.audits.count).to eq 2
      end

    end
  end
end
