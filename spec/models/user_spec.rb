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

  describe 'métodos' do
    it 'busca testemunhas em Leilão' do
      user = FactoryGirl.create(:user)
      primeiro_leilao = FactoryGirl.create(:leilao, testemunha_1: user)
      segundo_leilao = FactoryGirl.create(:leilao, testemunha_2: user)
      expect(user.testemunhas).to eq([primeiro_leilao, segundo_leilao])
    end
  end

  describe 'associações' do

    # has_many :alertas
    # has_many :audits

    let(:user) { FactoryGirl.create(:user) }

    it 'has_many testemunha_1' do
      primeiro_leilao = FactoryGirl.create(:leilao, testemunha_1: user)
      segundo_leilao = FactoryGirl.create(:leilao, testemunha_1: user)
      expect(user.testemunha_1).to eq([primeiro_leilao, segundo_leilao])
    end

    it 'has_many testemunha_2' do
      primeiro_leilao = FactoryGirl.create(:leilao, testemunha_2: user)
      segundo_leilao = FactoryGirl.create(:leilao, testemunha_2: user)
      expect(user.testemunha_2).to eq([primeiro_leilao, segundo_leilao])
    end

    it 'has_many leilao_observacoes' do
      leilao = FactoryGirl.create(:leilao)
      primeira_leilao_observacao = FactoryGirl.create(:leilao_observacao, user: user, leilao: leilao)
      segunda_leilao_observacao = FactoryGirl.create(:leilao_observacao, user: user, leilao: leilao)
      expect(user.leilao_observacoes).to eq([primeira_leilao_observacao, segunda_leilao_observacao])
    end

    it 'has_many alertas' do
      user = FactoryGirl.create(:user)
      cliente = FactoryGirl.create(:cliente)
      primerio_alerta = FactoryGirl.create(:alerta, user: user, cliente: cliente)
      segundo_alerta = FactoryGirl.create(:alerta, user: user, cliente: cliente)
      expect(user.alertas).to eq([primerio_alerta, segundo_alerta])
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:user) { FactoryGirl.create(:user) }

      it 'criação de Telefone' do
        expect(user.audits.count).to eq 1
      end

      it 'alteração de Telefone' do
        user.email = "Novo email"
        user.save
        expect(user.audits.count).to eq 2
      end

      it 'exclusão de Telefone' do
        user.destroy
        expect(user.audits.count).to eq 2
      end

    end
  end

end
