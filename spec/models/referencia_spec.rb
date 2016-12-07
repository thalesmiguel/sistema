require 'rails_helper'

RSpec.describe Referencia, type: :model do

  describe 'validações' do
    it 'exige nome' do
      cliente = FactoryGirl.create(:cliente)
      referencia = Referencia.new(FactoryGirl.attributes_for(:referencia, nome: '', cliente: cliente))
      expect(referencia.valid?).to be_falsy
    end
  end

  describe 'associações' do

    it 'belongs_to Cliente' do
      referencia = Referencia.new(FactoryGirl.attributes_for(:referencia, cliente: nil))
      expect(referencia.valid?).to be_falsy
    end
  end

  describe 'log' do
    describe 'gera log de' do
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:referencia) { FactoryGirl.create(:referencia, cliente: cliente) }
      it 'criação de Tag' do
        expect(referencia.audits.count).to eq 1
      end
      it 'alteração de Tag' do
        referencia.nome = "Novo nome"
        referencia.save
        expect(referencia.audits.count).to eq 2
      end
      it 'exclusão de Tag' do
        referencia.destroy
        expect(referencia.audits.count).to eq 2
      end
    end
  end

end
