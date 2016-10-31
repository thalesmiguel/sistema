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
end
