require 'rails_helper'

RSpec.describe Empresa, type: :model do
  describe 'validações' do
    it 'exige nome' do
      cliente = FactoryGirl.create(:cliente)
      empresa = Empresa.new(FactoryGirl.attributes_for(:empresa, nome: '', cliente: cliente))
      expect(empresa.valid?).to be_falsy
    end
  end

  describe 'associações' do

    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'belongs_to Cidade mas não exige Cidade' do
      empresa = Empresa.new(FactoryGirl.attributes_for(:empresa, cidade: nil, cliente: cliente))
      expect(empresa.valid?).to be_truthy
    end

    it 'belongs_to Cliente' do
      empresa = Empresa.new(FactoryGirl.attributes_for(:empresa, cliente: nil))
      expect(empresa.valid?).to be_falsy
    end
  end

  describe 'log' do
    describe 'gera log de' do
      let(:estado) { FactoryGirl.create(:estado) }
      let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:empresa) { FactoryGirl.create(:empresa, cliente: cliente, cidade: cidade) }

      it 'criação de Tag' do
        expect(empresa.audits.count).to eq 1
      end
      it 'alteração de Tag' do
        empresa.nome = "Novo nome"
        empresa.save
        expect(empresa.audits.count).to eq 2
      end
      it 'exclusão de Tag' do
        empresa.destroy
        expect(empresa.audits.count).to eq 2
      end
    end
  end

end
