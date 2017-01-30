require 'rails_helper'

RSpec.describe Leilao, type: :model do

  describe 'validações' do
    it 'exige nome' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, nome: ""))
      expect(leilao.valid?).to be_falsy
    end

    it 'grava logo' do
      leilao = FactoryGirl.create(:leilao)
      expect(leilao.logo_file_name).to eq("imagem.png")
    end
  end

  describe 'associações' do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
    let(:user) { FactoryGirl.create(:user) }

    it 'belongs_to Cidade' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, cidade: cidade))
      expect(leilao.cidade).to eq(cidade)
    end

    it 'belongs_to User (testemunha_1)' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, testemunha_1: user))
      expect(leilao.testemunha_1).to eq(user)
    end

    it 'belongs_to User (testemunha_2)' do
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, testemunha_2: user))
      expect(leilao.testemunha_2).to eq(user)
    end

    it 'belongs_to Subtipo' do
      subtipo = FactoryGirl.create(:subtipo)
      leilao = Leilao.new(FactoryGirl.attributes_for(:leilao, subtipo_lotes: subtipo))
      expect(leilao.subtipo_lotes).to eq(subtipo)
    end

    it 'has_many LeilaoComentarios' do
      leilao = FactoryGirl.create(:leilao)
      user = FactoryGirl.create(:user)
      primeira_leilao_observacao = FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user)
      segunda_leilao_observacao = FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user)
      expect(leilao.leilao_observacoes).to eq([primeira_leilao_observacao, segunda_leilao_observacao])
    end

    it 'has_one LeilaoEvento' do
      leilao = FactoryGirl.create(:leilao)
      leilao_evento = FactoryGirl.create(:leilao_evento, leilao: leilao)
      expect(leilao.leilao_evento).to eq(leilao_evento)
    end

    it 'belongs_to leilao_anterior & has_one leilao_posterior' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao, leilao_anterior: primeiro_leilao)
      terceiro_leilao = FactoryGirl.create(:leilao, leilao_anterior: primeiro_leilao)
      expect(segundo_leilao.leilao_anterior).to eq(primeiro_leilao)
      expect(primeiro_leilao.leilao_posterior).to eq([segundo_leilao, terceiro_leilao])
    end

    it 'has_many :promotores, through LeilaoPromotores' do
      primeiro_cliente = FactoryGirl.create(:cliente)
      segundo_cliente = FactoryGirl.create(:cliente)
      leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: primeiro_cliente, leilao: leilao)
      segundo_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: segundo_cliente, leilao: leilao)
      expect(leilao.promotores).to eq([primeiro_cliente, segundo_cliente])
    end

    it 'has_many :convidados, through LeilaoConvidados' do
      primeiro_cliente = FactoryGirl.create(:cliente)
      segundo_cliente = FactoryGirl.create(:cliente)
      leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: primeiro_cliente, leilao: leilao)
      segundo_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: segundo_cliente, leilao: leilao)
      expect(leilao.convidados).to eq([primeiro_cliente, segundo_cliente])
    end

    it 'has_many :bandeiras, through LeilaoBandeiras' do
      primeira_bandeira = FactoryGirl.create(:bandeira)
      segunda_bandeira = FactoryGirl.create(:bandeira)
      leilao = FactoryGirl.create(:leilao)
      primeira_leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: primeira_bandeira, leilao: leilao)
      segunda_leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: segunda_bandeira, leilao: leilao)
      expect(leilao.bandeiras).to eq([primeira_bandeira, segunda_bandeira])
    end

    it 'has_many :canais, through LeilaoCanais' do
      primeiro_canal = FactoryGirl.create(:canal)
      segundo_canal = FactoryGirl.create(:canal)
      leilao = FactoryGirl.create(:leilao)
      primeira_leilao_canal = FactoryGirl.create(:leilao_canal, canal: primeiro_canal, leilao: leilao)
      segunda_leilao_canal = FactoryGirl.create(:leilao_canal, canal: segundo_canal, leilao: leilao)
      expect(leilao.canais).to eq([primeiro_canal, segundo_canal])
    end

  end

  describe 'log' do

    describe 'gera log de' do

      it 'criação de Leilao' do
        leilao = FactoryGirl.create(:leilao)
        expect(leilao.audits.count).to eq 1
      end

      it 'alteração de Leilao' do
        leilao = FactoryGirl.create(:leilao)
        leilao.nome = "Novo nome"
        leilao.save
        expect(leilao.audits.count).to eq 2
      end

      it 'exclusão de Leilao' do
        leilao = FactoryGirl.create(:leilao)
        leilao.destroy
        expect(leilao.audits.count).to eq 2
      end

    end
  end
end
