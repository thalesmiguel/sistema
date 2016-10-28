require 'rails_helper'

RSpec.describe Endereco, type: :model do

  describe 'validações' do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'exige logradouro' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, logradouro: '', cidade: cidade, cliente: cliente))
      expect(endereco.valid?).to be_falsy
    end

    it 'deve existir pelo menos um ativo' do
      primeiro_endereco = FactoryGirl.create(:endereco, ativo: true, cidade: cidade, cliente: cliente)
      segundo_endereco = FactoryGirl.create(:endereco, ativo: true, cidade: cidade, cliente: cliente)
      primeiro_endereco.update(ativo: false)
      segundo_endereco.update(ativo: false)
      segundo_endereco.valid?
      expect(segundo_endereco.errors[:ativo]).to include('pelo menos 1 endereço deve estar ativo')
    end
    it 'deve existir somente um primário'
  end

  describe 'associações' do
    it 'belongs_to Cliente' do
      endereco = Endereco.new(FactoryGirl.attributes_for(:endereco, cliente: nil))
      expect(endereco.valid?).to be_falsy
    end
  end
end
