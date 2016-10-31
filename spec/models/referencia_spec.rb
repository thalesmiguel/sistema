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
end
