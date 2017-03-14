require 'rails_helper'

RSpec.describe Cidade, type: :model do

  describe 'validações' do

    it 'exige nome' do
      estado = FactoryGirl.create(:estado)
      cidade = Cidade.new(FactoryGirl.attributes_for(:cidade, nome: '', estado: estado))
      expect(cidade.valid?).to be_falsy
    end

    it 'é única por estado' do
      estado = FactoryGirl.create(:estado)
      primeira_cidade = FactoryGirl.create(:cidade, nome: 'Araçatuba', estado: estado)
      segunda_cidade = Cidade.new(nome: 'Araçatuba', estado: estado)
      expect(segunda_cidade.valid?).to be_falsy
    end
  end

  describe 'associações' do
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { Cidade.new(FactoryGirl.attributes_for(:cidade, estado: estado)) }
    let(:cliente) { FactoryGirl.create(:cliente) }

    it 'belongs_to Estado' do
      cidade = Cidade.new(FactoryGirl.attributes_for(:cidade, estado: nil))
      expect(cidade.valid?).to be_truthy
    end

    it 'has_many Bairros' do
      primeiro_bairro = FactoryGirl.create(:bairro, cidade: cidade)
      segundo_bairro = FactoryGirl.create(:bairro, cidade: cidade)
      expect(cidade.bairros).to eq([primeiro_bairro, segundo_bairro])
    end

    it 'has_many Endereços' do
      primeiro_endereco = FactoryGirl.create(:endereco, cidade: cidade, cliente: cliente)
      segundo_endereco = FactoryGirl.create(:endereco, primario: false, cidade: cidade, cliente: cliente)
      expect(cidade.enderecos).to eq([primeiro_endereco, segundo_endereco])
    end

    it 'has_many Fazendas' do
      primeira_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      segunda_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      expect(cidade.fazendas).to eq([primeira_fazenda, segunda_fazenda])
    end

    it 'has_many Cliente_Bancos' do
      banco = FactoryGirl.create(:banco)
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = FactoryGirl.create(:cliente_banco, primario: false, banco: banco, cidade: cidade, cliente: cliente)
      expect(cidade.cliente_bancos).to eq([primeiro_cliente_banco, segundo_cliente_banco])
    end

    it 'has_many Empresas' do
      primeira_empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      segunda_empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      expect(cidade.empresas).to eq([primeira_empresa, segunda_empresa])
    end

    it 'has_many Leilões' do
      primerio_leilao = FactoryGirl.create(:leilao, cidade: cidade)
      segundo_leilao = FactoryGirl.create(:leilao, cidade: cidade)
      expect(cidade.leiloes).to eq([primerio_leilao, segundo_leilao])
    end

    it 'has_many Leilões' do
      primerio_leiloeiro = FactoryGirl.create(:leiloeiro, cidade: cidade)
      segundo_leiloeiro = FactoryGirl.create(:leiloeiro, cidade: cidade)
      expect(cidade.leiloeiros).to eq([primerio_leiloeiro, segundo_leiloeiro])
    end
  end

  describe 'log' do

    describe 'gera log de' do

      it 'criação de Cidade' do
        cidade = FactoryGirl.create(:cidade)
        expect(cidade.audits.count).to eq 1
      end

      it 'alteração de Cidade' do
        cidade = FactoryGirl.create(:cidade)
        cidade.nome = "Novo nome"
        cidade.save
        expect(cidade.audits.count).to eq 2
      end

      it 'exclusão de Cidade' do
        cidade = FactoryGirl.create(:cidade)
        cidade.destroy
        expect(cidade.audits.count).to eq 2
      end

    end
  end
end
