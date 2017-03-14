require 'rails_helper'

RSpec.describe Bairro, type: :model do

  describe 'validações' do
    let(:cidade) { FactoryGirl.create(:cidade) }

    it 'exige nome' do
      cidade = FactoryGirl.create(:cidade)
      bairro = Bairro.new(FactoryGirl.attributes_for(:bairro, nome: '', cidade: cidade))
      expect(bairro.valid?).to be_falsy
    end

    it 'é única por cidade' do
      cidade = FactoryGirl.create(:cidade)
      primeira_bairro = FactoryGirl.create(:bairro, nome: 'Araçatuba', cidade: cidade)
      segunda_bairro = Bairro.new(nome: 'Araçatuba', cidade: cidade)
      expect(segunda_bairro.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:cidade) { FactoryGirl.create(:cidade) }
    let(:cliente) { FactoryGirl.create(:cliente) }
    let(:logradouro) { FactoryGirl.create(:logradouro) }

    it 'belongs_to Cidade' do
      bairro = Bairro.new(FactoryGirl.attributes_for(:bairro, cidade: cidade))
      expect(bairro.cidade).to eq cidade
    end

    it 'has_many Logradouros' do
      bairro = FactoryGirl.create(:bairro, id: 10, cidade: cidade)
      primeiro_logradouro = FactoryGirl.create(:logradouro, bairro: bairro)
      segundo_logradouro = FactoryGirl.create(:logradouro, bairro: bairro)
      expect(bairro.logradouros).to eq [primeiro_logradouro, segundo_logradouro]
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:cidade) { FactoryGirl.create(:cidade) }

      it 'criação de Bairro' do
        bairro = FactoryGirl.create(:bairro, cidade: cidade)
        expect(bairro.audits.count).to eq 1
      end

      it 'alteração de Bairro' do
        bairro = FactoryGirl.create(:bairro, cidade: cidade)
        bairro.nome = "Novo nome"
        bairro.save
        expect(bairro.audits.count).to eq 2
      end

      it 'exclusão de Bairro' do
        bairro = FactoryGirl.create(:bairro, cidade: cidade)
        bairro.destroy
        expect(bairro.audits.count).to eq 2
      end

    end
  end
end
