require 'rails_helper'

RSpec.describe Endereco, type: :model do

  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
  let(:cliente) { FactoryGirl.create(:cliente) }

  describe 'validações' do

    it 'exige logradouro' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, logradouro: '', cidade: cidade, cliente: cliente))
      expect(endereco.valid?).to be_falsy
    end

    it 'exige que o primeiro adicionado seja ativo' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, ativo: false, cidade: cidade, cliente: cliente))
      expect(endereco.valid?).to be_falsy
    end

    it 'deve existir pelo menos um ativo' do
      primeiro_endereco = FactoryGirl.create(:endereco, cidade: cidade, cliente: cliente)
      segundo_endereco = FactoryGirl.create(:endereco, primario: false, cidade: cidade, cliente: cliente)
      primeiro_endereco.update(ativo: false)
      segundo_endereco.update(ativo: false)
      segundo_endereco.valid?
      expect(segundo_endereco.errors[:ativo]).to include('pelo menos 1 deve estar ativo')
    end

    it 'exige que o primeiro adicionado seja primario' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, primario: false, cidade: cidade, cliente: cliente))
      expect(endereco.valid?).to be_falsy
    end

    it 'deve existir somente um primário' do
      primeiro_endereco = FactoryGirl.create(:endereco, primario: true, cidade: cidade, cliente: cliente)
      segundo_endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, primario: true, cidade: cidade, cliente: cliente))
      segundo_endereco.valid?
      expect(segundo_endereco.errors[:primario]).to include('somente 1 deve ser primário')
    end

  end

  describe 'associações' do

    it 'belongs_to Cliente' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, cliente: nil, cidade: cidade))
      expect(endereco.valid?).to be_falsy
    end

    it 'belongs_to Cidade' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, cliente: cliente, cidade: nil))
      expect(endereco.valid?).to be_falsy
    end
  end
end
