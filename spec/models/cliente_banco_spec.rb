require 'rails_helper'

RSpec.describe ClienteBanco, type: :model do

  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:banco) { FactoryGirl.create(:banco) }

  describe 'validações' do
    
    it 'exige que o primeiro adicionado seja ativo' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, ativo: false, banco: banco, cidade: cidade, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'deve existir pelo menos um ativo' do
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, primario: false, cidade: cidade, cliente: cliente)
      primeiro_cliente_banco.update(ativo: false)
      segundo_cliente_banco.update(ativo: false)
      segundo_cliente_banco.valid?
      expect(segundo_cliente_banco.errors[:ativo]).to include('pelo menos 1 deve estar ativo')
    end

    it 'exige que o primeiro adicionado seja primario' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, primario: false, banco: banco, cidade: cidade, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'deve existir somente um primário' do
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, primario: true, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, primario: true, banco: banco, cidade: cidade, cliente: cliente))
      segundo_cliente_banco.valid?
      expect(segundo_cliente_banco.errors[:primario]).to include('somente 1 deve ser primário')
    end

  end

  describe 'associações' do

    it 'belongs_to Banco' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, banco: nil, cidade: cidade, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'belongs_to Cidade' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, banco: banco, cidade: nil, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'belongs_to Cliente' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, banco: banco, cidade: cidade, cliente: nil))
      expect(cliente_banco.valid?).to be_falsy
    end

  end

end
