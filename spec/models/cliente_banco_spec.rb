require 'rails_helper'

RSpec.describe ClienteBanco, type: :model do

  let(:estado) { FactoryGirl.create(:estado) }
  let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
  let(:cliente) { FactoryGirl.create(:cliente) }
  let(:banco) { FactoryGirl.create(:banco) }

  describe 'validações' do

    it 'exige que o primeiro adicionado seja ativo' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, ativo: false, banco: banco, cidade: cidade, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'deve existir pelo menos um ativo' do
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, primario: false, cidade: cidade, cliente: cliente)
      primeiro_cliente_banco.update(ativo: false)
      segundo_cliente_banco.update(ativo: false)
      segundo_cliente_banco.valid?
      expect(segundo_cliente_banco.errors[:ativo]).to include('pelo menos 1 deve estar ativo')
    end

    it 'exige que o primeiro adicionado seja primario' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, primario: false, banco: banco, cidade: cidade, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'deve existir somente um primário' do
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, primario: true, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, primario: true, banco: banco, cidade: cidade, cliente: cliente))
      segundo_cliente_banco.valid?
      expect(segundo_cliente_banco.errors[:primario]).to include('somente 1 deve ser primário')
    end

  end

  describe 'associações' do

    it 'belongs_to Banco' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, banco: nil, cidade: cidade, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'belongs_to Cidade' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, banco: banco, cidade: nil, cliente: cliente))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'belongs_to Cliente' do
      cliente_banco = ClienteBanco.new(FactoryGirl.attributes_for(:cliente_banco, banco: banco, cidade: cidade, cliente: nil))
      expect(cliente_banco.valid?).to be_falsy
    end

    it 'has_many LeilaoComissoes' do
      cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      leilao = FactoryGirl.create(:leilao)
      primeira_leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao, promotor_banco: cliente_banco)
      segunda_leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao, promotor_banco: cliente_banco)
      expect(cliente_banco.leilao_comissoes).to eq [primeira_leilao_comissao, segunda_leilao_comissao]
    end

  end

  describe 'log' do
    let(:cliente_banco) { FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente) }
    describe 'gera log de' do

      it 'criação de Tag' do
        expect(cliente_banco.audits.count).to eq 1
      end
      it 'alteração de Tag' do
        cliente_banco.agencia = "Novo cliente_banco"
        cliente_banco.save
        expect(cliente_banco.audits.count).to eq 2
      end
      it 'exclusão de Tag' do
        cliente_banco.destroy
        expect(cliente_banco.audits.count).to eq 2
      end
    end
  end

end
