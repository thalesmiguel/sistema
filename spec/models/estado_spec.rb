require 'rails_helper'

RSpec.describe Estado, type: :model do

  describe 'validações' do
    it 'exige nome' do
      estado = Estado.new(FactoryGirl.attributes_for(:estado, nome: ''))
      expect(estado.valid?).to be_falsy
    end

    it 'nome deve ser único' do
      primeiro_estado = FactoryGirl.create(:estado, nome: 'São Paulo')
      segundo_estado = Estado.new(FactoryGirl.attributes_for(:estado, nome: 'São Paulo'))
      expect(segundo_estado.valid?).to be_falsy
    end

    it 'exige sigla' do
      estado = Estado.new(FactoryGirl.attributes_for(:estado, sigla: ''))
      expect(estado.valid?).to be_falsy
    end

    it 'sigla deve ser única' do
      primeiro_estado = FactoryGirl.create(:estado, sigla: 'SP')
      segundo_estado = Estado.new(FactoryGirl.attributes_for(:estado, sigla: 'SP'))
      expect(segundo_estado.valid?).to be_falsy
    end

    it 'sigla não pode ter mais do que 2 caracteres' do
      estado = Estado.new(FactoryGirl.attributes_for(:estado, sigla: 'ABC'))
      estado.valid?
      expect(estado.errors[:sigla]).to include('deve ter 2 caracteres')
    end
  end

  describe 'associações' do
    it 'has_many Cidades' do
      primeiro_estado = FactoryGirl.create(:estado)
      segundo_estado = FactoryGirl.create(:estado)
      primeira_cidade = FactoryGirl.create(:cidade, estado: primeiro_estado)
      segunda_cidade = FactoryGirl.create(:cidade, estado: primeiro_estado)
      terceira_cidade = FactoryGirl.create(:cidade, estado: segundo_estado)
      expect(primeiro_estado.cidades).to eq([primeira_cidade, segunda_cidade])
    end
  end

  describe 'log' do

    describe 'gera log de' do

      let(:estado) { FactoryGirl.create(:estado) }

      it 'criação de Estado' do
        expect(estado.audits.count).to eq 1
      end

      it 'alteração de Estado' do
        estado.nome = "Novo nome"
        estado.save
        expect(estado.audits.count).to eq 2
      end

      it 'exclusão de Estado' do
        estado.destroy
        expect(estado.audits.count).to eq 2
      end

    end
  end
end
