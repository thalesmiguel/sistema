require 'rails_helper'

RSpec.describe LancarAutorizado, type: :model do

  describe 'validações' do

    it 'exige nome' do
      cliente = FactoryGirl.create(:cliente)
      autorizado_a_lancar = LancarAutorizado.new(FactoryGirl.attributes_for(:lancar_autorizado, nome: '', cliente: cliente))
      expect(autorizado_a_lancar.valid?).to be_falsy
    end

    it 'grava procuracao em PDF' do
      cliente = FactoryGirl.create(:cliente)
      autorizado_a_lancar = FactoryGirl.create(:lancar_autorizado, cliente: cliente)
      expect(autorizado_a_lancar.procuracao_file_name).to eq("arquivo.pdf")
    end
  end

  describe 'associações' do

    it 'belongs_to Cliente' do
      autorizado_a_lancar = LancarAutorizado.new(FactoryGirl.attributes_for(:lancar_autorizado, cliente: nil))
      expect(autorizado_a_lancar.valid?).to be_falsy
    end

  end

  describe 'log' do
    describe 'gera log de' do
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:lancar_autorizado) { FactoryGirl.create(:lancar_autorizado, cliente: cliente) }
      it 'criação de Tag' do
        expect(lancar_autorizado.audits.count).to eq 1
      end
      it 'alteração de Tag' do
        lancar_autorizado.nome = "Novo nome"
        lancar_autorizado.save
        expect(lancar_autorizado.audits.count).to eq 2
      end
      it 'exclusão de Tag' do
        lancar_autorizado.destroy
        expect(lancar_autorizado.audits.count).to eq 2
      end
    end
  end

end
