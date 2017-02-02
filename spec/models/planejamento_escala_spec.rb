require 'rails_helper'
require "money-rails/test_helpers"

RSpec.describe PlanejamentoEscala, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:funcionario) { FactoryGirl.create(:cliente, cadastro_tipo: "funcionário") }

    it 'exige leilao' do
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: nil, funcionario: funcionario))
      expect(planejamento_escala.valid?).to be_falsy
    end

    it 'exige funcionario' do
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: nil))
      expect(planejamento_escala.valid?).to be_falsy
    end

    it 'Cliente deve ser do tipo funcionário' do
      nao_funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'cliente')
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: nao_funcionario))
      expect(planejamento_escala.valid?).to be_falsy
    end

    it 'Sexo do Uniforme deve ser o mesmo do Funcionário' do
      uniforme = FactoryGirl.create(:uniforme, sexo: 'masculino')
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário', sexo: 'feminino')
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: funcionario, uniforme: uniforme))
      expect(planejamento_escala.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:funcionario) { FactoryGirl.create(:cliente, cadastro_tipo: "funcionário") }

    it 'belongs_to Leilao' do
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: funcionario))
      expect(planejamento_escala.leilao).to eq(leilao)
    end

    it 'belongs_to Cliente por :funcionario' do
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: funcionario))
      expect(planejamento_escala.funcionario).to eq(funcionario)
    end

    it 'belongs_to Funcao' do
      funcao = FactoryGirl.create(:funcao)
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: funcionario, funcao: funcao))
      expect(planejamento_escala.leilao).to eq(leilao)
    end

    it 'belongs_to Uniforme' do
      uniforme = FactoryGirl.create(:uniforme)
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: funcionario, uniforme: uniforme))
      expect(planejamento_escala.leilao).to eq(leilao)
    end
  end

  describe 'métodos' do
    it 'apresenta valor com 2 casas decimais' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário')
      leilao = FactoryGirl.create(:leilao)
      planejamento_escala = PlanejamentoEscala.new(FactoryGirl.attributes_for(:planejamento_escala, leilao: leilao, funcionario: funcionario, diaria_valor: 1.9999, despesa_valor: 1.9999))
      is_expected.to monetize(:diaria_valor).with_currency(:brl)
      is_expected.to monetize(:despesa_valor).with_currency(:brl)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:funcionario) { FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário') }
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de PlanejamentoEscala' do
        planejamento_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
        expect(planejamento_escala.audits.count).to eq 1
      end

      it 'alteração de PlanejamentoEscala' do
        planejamento_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
        planejamento_escala.avaliacao_observacao = 'Nova observação'
        planejamento_escala.save
        expect(planejamento_escala.audits.count).to eq 2
      end

      it 'exclusão de PlanejamentoEscala' do
        planejamento_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
        planejamento_escala.destroy
        expect(planejamento_escala.audits.count).to eq 2
      end

    end
  end
end
