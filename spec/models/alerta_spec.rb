require 'rails_helper'

RSpec.describe Alerta, type: :model do

  describe "validações" do

    it 'exige descrição' do
      cliente = FactoryGirl.create(:cliente)
      alerta = Alerta.new(FactoryGirl.attributes_for(:alerta, descricao: '', cliente: cliente))
      expect(alerta.valid?).to be_falsy
    end

  end

  describe "associações" do

    it 'belongs_to Cliente' do
      alerta = Alerta.new(FactoryGirl.attributes_for(:alerta, cliente: nil))
      expect(alerta.valid?).to be_falsy
    end

  end

end
