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
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:pagamento_condicao) { FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 2) }

    it 'has_many PagamentoParcela' do
      expect(pagamento_condicao.pagamento_parcelas.count).to eq 2
    end

    it 'has_many :leiloes_elite pela classe LeilaoPadrao e campo :pagamento_elite' do
      leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao, pagamento_elite: pagamento_condicao)
      expect(pagamento_condicao.leiloes_elite).to eq [leilao_padrao]
    end

    it 'has_many :leiloes_corte pela classe LeilaoPadrao e campo :pagamento_corte' do
      leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao, pagamento_corte: pagamento_condicao)
      expect(pagamento_condicao.leiloes_corte).to eq [leilao_padrao]
    end

    it 'has_many :leiloes_outros pela classe LeilaoPadrao e campo :pagamento_outros' do
      leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao, pagamento_outros: pagamento_condicao)
      expect(pagamento_condicao.leiloes_outros).to eq [leilao_padrao]
    end
  end

  describe 'métodos' do
    it 'mostra que a quantidade de captações conferem' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 2, captacoes: 4)
      primeira_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 2)
      segunda_parcela = FactoryGirl.create(:pagamento_parcela, pagamento_condicao: pagamento_condicao, parcela: 1, captacoes: 2)
      expect(pagamento_condicao.captacoes_conferem?).to be_truthy
    end

    it 'gera ParcelaPagamentos automaticamente' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao, parcelas: 4, captacoes: 4)
      expect(pagamento_condicao.pagamento_parcelas.count).to eq 4
    end

    it 'mostra todos os Leilões que utilizaram essa Condição de Pagamento' do
      pagamento_condicao = FactoryGirl.create(:pagamento_condicao)

      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      terceiro_leilao = FactoryGirl.create(:leilao)

      primeiro_leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: primeiro_leilao, pagamento_elite: pagamento_condicao)
      segundo_leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: segundo_leilao, pagamento_corte: pagamento_condicao)
      terceiro_leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: terceiro_leilao, pagamento_outros: pagamento_condicao)

      expect(pagamento_condicao.utilizado_em).to eq [primeiro_leilao_padrao, segundo_leilao_padrao, terceiro_leilao_padrao]
    end
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
