require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validações' do
    it 'exige username' do
      user = User.new(FactoryGirl.attributes_for(:user, username: ''))
      expect(user.valid?).to be_falsy
    end

    it 'username deve ser único' do
      primeiro_user = FactoryGirl.create(:user, username: 'thales.miguel')
      segundo_user = User.new(FactoryGirl.attributes_for(:user, username: 'thales.miguel'))
      expect(segundo_user.valid?).to be_falsy
    end

    it 'email pode ser nulo' do
      user = User.new(FactoryGirl.attributes_for(:user, email: ''))
      expect(user.valid?).to be_truthy
    end

    it 'email pode ser nulo em vários Users' do
      primeiro_user = FactoryGirl.create(:user, email: '')
      segundo_user = User.new(FactoryGirl.attributes_for(:user, email: ''))
      expect(segundo_user.valid?).to be_truthy
    end

    it 'email deve ser único' do
      primeiro_user = FactoryGirl.create(:user, email: 'thales.miguel@gmail.com')
      segundo_user = User.new(FactoryGirl.attributes_for(:user, email: 'thales.miguel@gmail.com'))
      expect(segundo_user.valid?).to be_falsy
    end

  end

end
