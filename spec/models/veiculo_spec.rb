require 'rails_helper'

RSpec.describe Veiculo, type: :model do

  describe 'validações' do
    it 'exige modelo' do
      veiculo = Veiculo.new(FactoryGirl.attributes_for(:veiculo, modelo: ''))
      expect(veiculo.valid?).to be_falsy
    end
  end

  describe 'associações' do
    it 'has_many PlanejamentoVeiculos' do
      veiculo = FactoryGirl.create(:veiculo, disponivel_viagem: true)
      primeiro_planejamento = FactoryGirl.create(:planejamento_veiculo, veiculo: veiculo)
      segundo_planejamento = FactoryGirl.create(:planejamento_veiculo, veiculo: veiculo)
      expect(veiculo.planejamento_veiculos).to eq [primeiro_planejamento, segundo_planejamento]
    end
  end

  describe 'log' do

    describe 'gera log de' do
      it 'criação de Veiculo' do
        veiculo = FactoryGirl.create(:veiculo)
        expect(veiculo.audits.count).to eq 1
      end

      it 'alteração de Veiculo' do
        veiculo = FactoryGirl.create(:veiculo)
        veiculo.modelo = 'Novo modelo'
        veiculo.save
        expect(veiculo.audits.count).to eq 2
      end

      it 'exclusão de Veiculo' do
        veiculo = FactoryGirl.create(:veiculo)
        veiculo.destroy
        expect(veiculo.audits.count).to eq 2
      end
    end
  end
end
