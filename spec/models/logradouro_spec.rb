require 'rails_helper'

RSpec.describe Logradouro, type: :model do

  describe 'validações' do

    it 'exige nome' do
      logradouro = Logradouro.new(FactoryGirl.attributes_for(:logradouro, nome: ''))
      expect(logradouro.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:logradouro) { Logradouro.new(FactoryGirl.attributes_for(:logradouro, estado: estado)) }
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'belongs_to Bairro' do
      logradouro = Logradouro.new(FactoryGirl.attributes_for(:logradouro, bairro: nil))
      expect(logradouro.valid?).to be_falsy
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:cidade) { FactoryGirl.create(:cidade) }
      let(:bairro) { FactoryGirl.create(:bairro, cidade: cidade) }

      it 'criação de Logradouro' do
        logradouro = FactoryGirl.create(:logradouro, bairro: bairro)
        expect(logradouro.audits.count).to eq 1
      end

      it 'alteração de Logradouro' do
        logradouro = FactoryGirl.create(:logradouro, bairro: bairro)
        logradouro.nome = "Novo nome"
        logradouro.save
        expect(logradouro.audits.count).to eq 2
      end

      it 'exclusão de Logradouro' do
        logradouro = FactoryGirl.create(:logradouro, bairro: bairro)
        logradouro.destroy
        expect(logradouro.audits.count).to eq 2
      end

    end
  end
end
