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

end
