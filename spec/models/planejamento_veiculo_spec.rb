require 'rails_helper'

RSpec.describe PlanejamentoVeiculo, type: :model do

  describe 'validações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:veiculo) { FactoryGirl.create(:veiculo, disponivel_viagem: true) }

    it 'exige Leilao' do
      planejamento_veiculo = PlanejamentoVeiculo.new(FactoryGirl.attributes_for(:planejamento_veiculo, leilao: nil, veiculo: veiculo))
      expect(planejamento_veiculo.valid?).to be_falsy
    end

    it 'exige Veiculo' do
      planejamento_veiculo = PlanejamentoVeiculo.new(FactoryGirl.attributes_for(:planejamento_veiculo, leilao: leilao, veiculo: nil))
      expect(planejamento_veiculo.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:leilao) { FactoryGirl.create(:leilao) }
    let(:veiculo) { FactoryGirl.create(:veiculo, disponivel_viagem: true) }
    let(:funcionario) { FactoryGirl.create(:cliente, cadastro_tipo: "funcionário") }

    it 'belongs_to Leilao' do
      planejamento_veiculo = PlanejamentoVeiculo.new(FactoryGirl.attributes_for(:planejamento_veiculo, leilao: leilao, veiculo: veiculo))
      expect(planejamento_veiculo.leilao).to eq(leilao)
    end

    it 'belongs_to Veiculo' do
      planejamento_veiculo = PlanejamentoVeiculo.new(FactoryGirl.attributes_for(:planejamento_veiculo, leilao: leilao, veiculo: veiculo))
      expect(planejamento_veiculo.veiculo).to eq(veiculo)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:leilao) { FactoryGirl.create(:leilao) }
      let(:veiculo) { FactoryGirl.create(:veiculo, disponivel_viagem: true) }

      it 'criação de PlanejamentoVeiculo' do
        planejamento_veiculo = FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo)
        expect(planejamento_veiculo.audits.count).to eq 1
      end

      it 'alteração de PlanejamentoVeiculo' do
        planejamento_veiculo = FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo)
        planejamento_veiculo.observacao = 'Nova observação'
        planejamento_veiculo.save
        expect(planejamento_veiculo.audits.count).to eq 2
      end

      it 'exclusão de PlanejamentoVeiculo' do
        planejamento_veiculo = FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo)
        planejamento_veiculo.destroy
        expect(planejamento_veiculo.audits.count).to eq 2
      end

    end
  end
end
