require 'rails_helper'

RSpec.describe Telefone, type: :model do

  let(:cliente) { FactoryGirl.create(:cliente) }

  describe 'validações' do

    it 'exige DDI' do
      telefone = Telefone.new(FactoryGirl.attributes_for(:telefone, ddi: '', cliente: cliente))
      expect(telefone.valid?).to be_falsy
    end

    it 'exige DDD' do
      telefone = Telefone.new(FactoryGirl.attributes_for(:telefone, ddd: '', cliente: cliente))
      expect(telefone.valid?).to be_falsy
    end

    it 'exige numero' do
      telefone = Telefone.new(FactoryGirl.attributes_for(:telefone, numero: '', cliente: cliente))
      expect(telefone.valid?).to be_falsy
    end

    it 'exige que o primeiro adicionado seja ativo' do
      telefone = Telefone.new(FactoryGirl.attributes_for(:telefone, ativo: false, cliente: cliente))
      expect(telefone.valid?).to be_falsy
    end

    it 'deve existir pelo menos um ativo' do
      primeiro_telefone = FactoryGirl.create(:telefone, cliente: cliente)
      segundo_telefone = FactoryGirl.create(:telefone, cliente: cliente)
      primeiro_telefone.update(ativo: false)
      segundo_telefone.update(ativo: false)
      segundo_telefone.valid?
      expect(segundo_telefone.errors[:ativo]).to include('pelo menos 1 deve estar ativo')
    end
  end

  describe 'associações' do
    it 'belongs_to Cliente' do
      telefone = Telefone.new(FactoryGirl.attributes_for(:telefone, cliente: nil))
      expect(telefone.valid?).to be_falsy
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:telefone) { FactoryGirl.create(:telefone, cliente: cliente) }

      it 'criação de Telefone' do
        expect(telefone.audits.count).to eq 1
      end

      it 'alteração de Telefone' do
        telefone.numero = "Novo número"
        telefone.save
        expect(telefone.audits.count).to eq 2
      end

      it 'exclusão de Telefone' do
        telefone.destroy
        expect(telefone.audits.count).to eq 2
      end

    end
  end
end
