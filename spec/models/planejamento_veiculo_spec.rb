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
    let(:segundo_funcionario) { FactoryGirl.create(:cliente, cadastro_tipo: "funcionário") }

    it 'belongs_to Leilao' do
      planejamento_veiculo = PlanejamentoVeiculo.new(FactoryGirl.attributes_for(:planejamento_veiculo, leilao: leilao, veiculo: veiculo))
      expect(planejamento_veiculo.leilao).to eq(leilao)
    end

    it 'belongs_to Veiculo' do
      planejamento_veiculo = PlanejamentoVeiculo.new(FactoryGirl.attributes_for(:planejamento_veiculo, leilao: leilao, veiculo: veiculo))
      expect(planejamento_veiculo.veiculo).to eq(veiculo)
    end

    context 'has_many :planejamento_veiculos, through PlanejamentoViagens' do
      let(:planejamento_veiculo) { FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo) }
      let(:primeiro_planejamento_escala) { FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario) }
      let(:segundo_planejamento_escala) { FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: segundo_funcionario) }
      it 'busca planejamento_escalas' do
        primeiro_planejamento_viagem = FactoryGirl.create(:planejamento_viagem, planejamento_escala: primeiro_planejamento_escala, planejamento_veiculo: planejamento_veiculo)
        segundo_planejamento_viagem = FactoryGirl.create(:planejamento_viagem, planejamento_escala: segundo_planejamento_escala, planejamento_veiculo: planejamento_veiculo)
        expect(planejamento_veiculo.planejamento_escalas).to eq([primeiro_planejamento_escala, segundo_planejamento_escala])
      end
      it 'apaga PlanejamentoViagens quando é destruído' do
        primeiro_planejamento_viagem = FactoryGirl.create(:planejamento_viagem, planejamento_escala: primeiro_planejamento_escala, planejamento_veiculo: planejamento_veiculo)
        segundo_planejamento_viagem = FactoryGirl.create(:planejamento_viagem, planejamento_escala: segundo_planejamento_escala, planejamento_veiculo: planejamento_veiculo)
        expect { planejamento_veiculo.destroy }.to change { PlanejamentoViagem.count }
      end
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
