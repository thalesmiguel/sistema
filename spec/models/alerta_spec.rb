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

  describe 'log' do

    describe 'gera log de' do
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente) }

      it 'criação de Telefone' do
        expect(alerta.audits.count).to eq 1
      end

      it 'alteração de Telefone' do
        alerta.descricao = "Nova descrição"
        alerta.save
        expect(alerta.audits.count).to eq 2
      end

      it 'exclusão de Telefone' do
        alerta.destroy
        expect(alerta.audits.count).to eq 2
      end

    end
  end

end
