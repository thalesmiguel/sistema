require 'rails_helper'

RSpec.describe PlanejamentoViagem, type: :model do
  let(:leilao) { FactoryGirl.create(:leilao) }
  let(:funcionario) { FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário') }
  let(:veiculo) { FactoryGirl.create(:veiculo) }
  let(:planejamento_escala) { FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario) }
  let(:planejamento_veiculo) { FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo) }

  describe 'validações' do
    it 'exige planejamento_escala' do
      planejamento_viagem = PlanejamentoViagem.new(FactoryGirl.attributes_for(:planejamento_viagem, planejamento_escala: nil, planejamento_veiculo: planejamento_veiculo))
      expect(planejamento_viagem.valid?).to be_falsy
    end

    it 'exige planejamento_viagem' do
      planejamento_viagem = PlanejamentoViagem.new(FactoryGirl.attributes_for(:planejamento_viagem, planejamento_escala: planejamento_escala, planejamento_veiculo: nil))
      expect(planejamento_viagem.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:planejamento_viagem) { FactoryGirl.create(:planejamento_viagem, planejamento_escala: planejamento_escala, planejamento_veiculo: planejamento_veiculo) }

    it 'belongs_to PlanejamentoEscala' do
      expect(planejamento_viagem.planejamento_escala).to eq(planejamento_escala)
    end

    it 'belongs_to PlanejamentoVeiculo' do
      expect(planejamento_viagem.planejamento_veiculo).to eq(planejamento_veiculo)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:planejamento_viagem) { FactoryGirl.create(:planejamento_viagem, planejamento_escala: planejamento_escala, planejamento_veiculo: planejamento_veiculo, ida: false) }

      it 'criação de PlanejamentoViagem' do
        expect(planejamento_viagem.audits.count).to eq 1
      end

      it 'alteração de PlanejamentoViagem' do
        novo_leilao = FactoryGirl.create(:leilao)
        planejamento_viagem.ida = true
        planejamento_viagem.save
        expect(planejamento_viagem.audits.count).to eq 2
      end

      it 'exclusão de PlanejamentoViagem' do
        planejamento_viagem.destroy
        expect(planejamento_viagem.audits.count).to eq 2
      end
    end
  end
end
