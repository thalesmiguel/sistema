require 'rails_helper'

RSpec.describe Email, type: :model do
  let(:cliente) { FactoryGirl.create(:cliente) }

  describe 'validações' do

    it 'exige email' do
      email = Email.new(FactoryGirl.attributes_for(:email, email: '', cliente: cliente))
      expect(email.valid?).to be_falsy
    end

    it 'exige o primeiro adicionado seja ativo' do
      email = Email.new(FactoryGirl.attributes_for(:email, ativo: false, cliente: cliente))
      expect(email.valid?).to be_falsy
    end

    it 'deve existir pelo menos um ativo' do
      primeiro_email = FactoryGirl.create(:email, cliente: cliente)
      segundo_email = FactoryGirl.create(:email, cliente: cliente)
      primeiro_email.update(ativo: false)
      segundo_email.update(ativo: false)
      segundo_email.valid?
      expect(segundo_email.errors[:ativo]).to include('pelo menos 1 deve estar ativo')
    end
  end

  describe 'associações' do
    it 'belongs_to Cliente' do
      email = Email.new(FactoryGirl.attributes_for(:email, cliente: nil))
      expect(email.valid?).to be_falsy
    end
  end
end
