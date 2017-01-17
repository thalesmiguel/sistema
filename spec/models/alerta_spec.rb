require 'rails_helper'

RSpec.describe Alerta, type: :model do

  describe "validações" do

    it 'exige descrição' do
      user = FactoryGirl.create(:user)
      cliente = FactoryGirl.create(:cliente)
      alerta = Alerta.new(FactoryGirl.attributes_for(:alerta, descricao: '', cliente: cliente, user: user))
      expect(alerta.valid?).to be_falsy
    end

  end

  describe "associações" do
    let(:user) { FactoryGirl.create(:user) }
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'belongs_to Cliente' do
      alerta = Alerta.new(FactoryGirl.attributes_for(:alerta, cliente: nil, user: user))
      expect(alerta.valid?).to be_falsy
    end

    it 'belongs_to User' do
      alerta = Alerta.new(FactoryGirl.attributes_for(:alerta, cliente: cliente, user: nil))
      expect(alerta.valid?).to be_falsy
    end

    it 'has_many ComentarioAlertas' do
      alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user)
      primeiro_alerta_comentario = FactoryGirl.create(:alerta_comentario, alerta: alerta)
      segundo_alerta_comentario = FactoryGirl.create(:alerta_comentario, alerta: alerta)
      expect(alerta.alerta_comentarios).to eq([primeiro_alerta_comentario, segundo_alerta_comentario])
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:user) { FactoryGirl.create(:user) }
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user: user) }

      it 'criação de Alerta' do
        expect(alerta.audits.count).to eq 1
      end

      it 'alteração de Alerta' do
        alerta.descricao = "Nova descrição"
        alerta.save
        expect(alerta.audits.count).to eq 2
      end

      it 'exclusão de Alerta' do
        alerta.destroy
        expect(alerta.audits.count).to eq 2
      end

    end
  end

end
