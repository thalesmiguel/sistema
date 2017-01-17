require 'rails_helper'

RSpec.describe AlertaComentario, type: :model do

  describe "validações" do

    it 'exige descrição' do
      user = FactoryGirl.create(:user)
      cliente = FactoryGirl.create(:cliente)
      alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user)
      alerta_comentario = AlertaComentario.new(FactoryGirl.attributes_for(:alerta_comentario, descricao: '', alerta: alerta))
      expect(alerta_comentario.valid?).to be_falsy
    end

  end

  describe "associações" do
    let(:user) { FactoryGirl.create(:user) }
    let(:cliente) { FactoryGirl.create(:cliente) }
    let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user: user)}

    it 'belongs_to Alerta' do
      alerta_comentario = AlertaComentario.new(FactoryGirl.attributes_for(:alerta_comentario, alerta: nil))
      expect(alerta_comentario.valid?).to be_falsy
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:user) { FactoryGirl.create(:user) }
      let(:cliente) { FactoryGirl.create(:cliente) }
      let(:alerta) { FactoryGirl.create(:alerta, cliente: cliente, user: user) }
      let(:alerta_comentario) { FactoryGirl.create(:alerta_comentario, alerta: alerta) }

      it 'criação de ComentarioAlerta' do
        expect(alerta_comentario.audits.count).to eq 1
      end

      it 'alteração de ComentarioAlerta' do
        alerta_comentario.descricao = "Nova descrição"
        alerta_comentario.save
        expect(alerta_comentario.audits.count).to eq 2
      end

      it 'exclusão de ComentarioAlerta' do
        alerta_comentario.destroy
        expect(alerta_comentario.audits.count).to eq 2
      end

    end
  end

end
