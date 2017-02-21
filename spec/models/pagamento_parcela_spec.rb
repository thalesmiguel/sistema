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

    context 'PagamentoCondicao.tipo é datas_diferenciadas' do
      it 'exige data de vencimento' do
        pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2, tipo: 'datas_diferenciadas')
        pagamento_parcela = PagamentoParcela.new(FactoryGirl.attributes_for(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1, vencimento: ''))
        expect(pagamento_parcela.valid?).to be_falsy
      end
    end

  end

  describe 'associações' do
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2) }

    it 'belongs_to PagamentoCondicao' do
      pagamento_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 1)
      expect(pagamento_parcela.pagamento_condicao).to eq pagamento_condicao
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
