require 'rails_helper'

RSpec.describe LancarAutorizado, type: :model do

  describe 'validações' do
    it 'exige nome' do
      cliente = FactoryGirl.create(:cliente)
      autorizado_a_lancar = LancarAutorizado.new(FactoryGirl.attributes_for(:lancar_autorizado, nome: '', cliente: cliente))
      expect(autorizado_a_lancar.valid?).to be_falsy
    end
  end

  describe 'associações' do
    it 'belongs_to Cliente' do
      autorizado_a_lancar = LancarAutorizado.new(FactoryGirl.attributes_for(:lancar_autorizado, cliente: nil))
      expect(autorizado_a_lancar.valid?).to be_falsy
    end
  end
end
