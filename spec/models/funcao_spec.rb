require 'rails_helper'

RSpec.describe Funcao, type: :model do

  describe 'validações' do

    it 'exige nome' do
      funcao = Funcao.new(FactoryGirl.attributes_for(:funcao, nome: ""))
      expect(funcao.valid?).to be_falsy
    end
  end

  describe 'associações' do

    it 'has_many PlanejamentoEscalas' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário')
      leilao = FactoryGirl.create(:leilao)
      funcao = FactoryGirl.create(:funcao)
      primeira_escala = FactoryGirl.create(:planejamento_escala, funcao: funcao, leilao: leilao, funcionario: funcionario)
      segunda_escala = FactoryGirl.create(:planejamento_escala, funcao: funcao, leilao: leilao, funcionario: funcionario)
      expect(funcao.planejamento_escalas).to eq [primeira_escala, segunda_escala]
    end
  end

  describe 'log' do

    describe 'gera log de' do

      it 'criação de Funcao' do
        funcao = FactoryGirl.create(:funcao)
        expect(funcao.audits.count).to eq 1
      end

      it 'alteração de Funcao' do
        funcao = FactoryGirl.create(:funcao)
        funcao.nome = 'Novo nome'
        funcao.save
        expect(funcao.audits.count).to eq 2
      end

      it 'exclusão de Funcao' do
        funcao = FactoryGirl.create(:funcao)
        funcao.destroy
        expect(funcao.audits.count).to eq 2
      end

    end
  end
end
