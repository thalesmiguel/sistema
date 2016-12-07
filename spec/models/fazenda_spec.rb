require 'rails_helper'

RSpec.describe Fazenda, type: :model do

  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
  let(:cliente) { FactoryGirl.create(:cliente) }

  describe "validações" do
    it 'exige nome' do
      fazenda = Fazenda.new(FactoryGirl.attributes_for(:fazenda, nome: '', cidade: cidade, cliente: cliente))
      expect(fazenda.valid?).to be_falsy
    end

    it 'deve existir pelo menos uma ativa' do
      primeira_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      segunda_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      primeira_fazenda.update(ativo: false)
      segunda_fazenda.update(ativo: false)
      segunda_fazenda.valid?
      expect(segunda_fazenda.errors[:ativo]).to include('pelo menos 1 deve estar ativo')
    end
  end

  describe "associações" do

    it 'belongs_to Cliente' do
      fazenda = Fazenda.new(FactoryGirl.attributes_for(:fazenda, cidade: cidade, cliente: nil))
      expect(fazenda.valid?).to be_falsy
    end

    it 'belongs_to Endereço' do
      fazenda = Fazenda.new(FactoryGirl.attributes_for(:fazenda, cidade: nil, cliente: cliente))
      expect(fazenda.valid?).to be_falsy
    end

  end

  describe 'log' do
    describe 'gera log de' do
      let(:estado) { FactoryGirl.create(:estado) }
      let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:fazenda) { FactoryGirl.create(:fazenda, cliente: cliente, cidade: cidade) }
      
      it 'criação de Tag' do
        expect(fazenda.audits.count).to eq 1
      end
      it 'alteração de Tag' do
        fazenda.nome = "Novo nome"
        fazenda.save
        expect(fazenda.audits.count).to eq 2
      end
      it 'exclusão de Tag' do
        fazenda.destroy
        expect(fazenda.audits.count).to eq 2
      end
    end
  end
end
