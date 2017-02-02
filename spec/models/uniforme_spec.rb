require 'rails_helper'

RSpec.describe Uniforme, type: :model do

  describe 'validações' do

    it 'exige nome' do
      uniforme = Uniforme.new(FactoryGirl.attributes_for(:uniforme, nome: ""))
      expect(uniforme.valid?).to be_falsy
    end
  end

  describe 'associações' do

    it 'has_many PlanejamentoEscalas' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário', sexo: 'feminino')
      leilao = FactoryGirl.create(:leilao)
      uniforme = FactoryGirl.create(:uniforme, sexo: 'feminino')
      primeira_escala = FactoryGirl.create(:planejamento_escala, uniforme: uniforme, leilao: leilao, funcionario: funcionario)
      segunda_escala = FactoryGirl.create(:planejamento_escala, uniforme: uniforme, leilao: leilao, funcionario: funcionario)
      expect(uniforme.planejamento_escalas).to eq [primeira_escala, segunda_escala]
    end
  end

  describe 'log' do

    describe 'gera log de' do

      it 'criação de Uniforme' do
        uniforme = FactoryGirl.create(:uniforme)
        expect(uniforme.audits.count).to eq 1
      end

      it 'alteração de Uniforme' do
        uniforme = FactoryGirl.create(:uniforme)
        uniforme.nome = 'Novo nome'
        uniforme.save
        expect(uniforme.audits.count).to eq 2
      end

      it 'exclusão de Uniforme' do
        uniforme = FactoryGirl.create(:uniforme)
        uniforme.destroy
        expect(uniforme.audits.count).to eq 2
      end

    end
  end
end
