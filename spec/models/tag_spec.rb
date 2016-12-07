require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe 'validações' do

    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'exige codigo' do
      tag = Tag.new(FactoryGirl.attributes_for(:tag, codigo: '', cliente: cliente))
      expect(tag.valid?).to be_falsy
    end

    it 'exige nome' do
      tag = Tag.new(FactoryGirl.attributes_for(:tag, nome: '', cliente: cliente))
      expect(tag.valid?).to be_falsy
    end
  end

  describe 'associações' do
    it 'belongs_to Cliente' do
      tag = Tag.new(FactoryGirl.attributes_for(:tag, cliente: nil))
      expect(tag.valid?).to be_falsy
    end
  end

  describe 'log' do
    describe 'gera log de' do
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:tag) { FactoryGirl.create(:tag, cliente: cliente) }
      it 'criação de Tag' do
        expect(tag.audits.count).to eq 1
      end
      it 'alteração de Tag' do
        tag.nome = "Novo nome"
        tag.save
        expect(tag.audits.count).to eq 2
      end
      it 'exclusão de Tag' do
        tag.destroy
        expect(tag.audits.count).to eq 2
      end
    end
  end

end
