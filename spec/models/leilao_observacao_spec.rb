require 'rails_helper'

RSpec.describe LeilaoObservacao, type: :model do

  describe 'validações' do
    let(:user) { FactoryGirl.create(:user) }
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'exige descricao' do
      leilao_observacao = LeilaoObservacao.new(FactoryGirl.attributes_for(:leilao_observacao, descricao: "", user: user, leilao: leilao))
      expect(leilao_observacao.valid?).to be_falsy
    end

    it 'exige user' do
      leilao_observacao = LeilaoObservacao.new(FactoryGirl.attributes_for(:leilao_observacao, user: nil, leilao: leilao))
      expect(leilao_observacao.valid?).to be_falsy
    end

    it 'exige leilao' do
      leilao_observacao = LeilaoObservacao.new(FactoryGirl.attributes_for(:leilao_observacao, user: user, leilao: nil))
      expect(leilao_observacao.valid?).to be_falsy
    end

  end

  describe 'associações' do
    let(:user) { FactoryGirl.create(:user) }
    let(:leilao) { FactoryGirl.create(:leilao) }

    it 'belongs_to Leilao' do
      leilao_observacao = LeilaoObservacao.new(FactoryGirl.attributes_for(:leilao_observacao, leilao: leilao))
      expect(leilao_observacao.leilao).to eq(leilao)
    end

    it 'belongs_to User' do
      leilao_observacao = LeilaoObservacao.new(FactoryGirl.attributes_for(:leilao_observacao, user: user))
      expect(leilao_observacao.user).to eq(user)
    end
  end

  describe 'log' do

    describe 'gera log de' do
      let(:user) { FactoryGirl.create(:user) }
      let(:leilao) { FactoryGirl.create(:leilao) }

      it 'criação de LeilaoObservacao' do
        leilao_observacao = FactoryGirl.create(:leilao_observacao, user: user, leilao: leilao)
        expect(leilao_observacao.audits.count).to eq 1
      end

      it 'alteração de LeilaoObservacao' do
        leilao_observacao = FactoryGirl.create(:leilao_observacao, user: user, leilao: leilao)
        leilao_observacao.descricao = "Novo nome"
        leilao_observacao.save
        expect(leilao_observacao.audits.count).to eq 2
      end

      it 'exclusão de LeilaoObservacao' do
        leilao_observacao = FactoryGirl.create(:leilao_observacao, user: user, leilao: leilao)
        leilao_observacao.destroy
        expect(leilao_observacao.audits.count).to eq 2
      end

    end
  end
end
