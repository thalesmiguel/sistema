require 'rails_helper'

RSpec.describe Cliente, type: :model do

  describe 'validações' do
    it 'exige nome' do
      cliente = Cliente.new(nome: '')
      cliente.valid?
      expect(cliente.errors[:nome]).to include("deve ser informado")
    end

    it 'exige que o cpf_cnpj seja único' do
      primeiro_cliente = FactoryGirl.create(:cliente, cpf_cnpj: '111.111.111-11')
      novo_cliente = Cliente.new(nome: "Nome", cpf_cnpj: '111.111.111-11')
      novo_cliente.valid?
      expect(novo_cliente.errors[:cpf_cnpj]).to include("já está em uso")
      # expect(novo_cliente.valid?).to be_falsy
    end

    it 'exige tipo de cadastro' do
      cliente = Cliente.new(FactoryGirl.attributes_for(:cliente, cadastro_tipo: ''))
      expect(cliente.valid?).to be_falsy
    end

    it 'exige tipos de marketing' do
      cliente = Cliente.new(FactoryGirl.attributes_for(:cliente, marketing_tipos: [ ]))
      expect(cliente.valid?).to be_falsy
    end

    it 'exige tipo de pessoa' do
      cliente = Cliente.new(FactoryGirl.attributes_for(:cliente, pessoa_tipo: ''))
      expect(cliente.valid?).to be_falsy
    end
  end

  describe 'métodos' do
    describe 'deve buscar Cliente' do
      let(:primeiro_cliente) { FactoryGirl.create(:cliente, nome: 'Alberto Silva', apelido: 'Alberto Silva', cpf_cnpj: '370.629.888-04') }
      let(:segundo_cliente) { FactoryGirl.create(:cliente, nome: 'Kleber Carvalho', apelido: 'Kleber Carvalho', cpf_cnpj: '999.999.999-04') }

      it 'por nome' do
        expect(Cliente.busca_por_campo("nome", "A")).to eq([primeiro_cliente])
      end

      it 'por apelido' do
        expect(Cliente.busca_por_campo("apelido", "Kle")).to eq([segundo_cliente])
      end

      it 'cpf_cnpj' do
        expect(Cliente.busca_por_campo("cpf_cnpj", "370.")).to eq([primeiro_cliente])
      end

      it 'por fazenda'
    end

    it 'deve ordenar busca por ordem alfabética' do
      primeiro_cliente = FactoryGirl.create(:cliente, nome: 'Thales Miguel')
      segundo_cliente = FactoryGirl.create(:cliente, nome: 'Thales Martinez')
      expect(Cliente.busca_por_campo("nome", "Thales")).to eq([segundo_cliente, primeiro_cliente])
    end
  end
end
