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
    context 'deve buscar Cliente' do
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

      it 'por fazendas' do
        estado = FactoryGirl.create(:estado)
        cidade = FactoryGirl.create(:cidade, estado: estado)
        fazenda = FactoryGirl.create(:fazenda, nome: "Minha Fazenda", cidade: cidade, cliente: primeiro_cliente)
        expect(Cliente.busca_por_associacao("fazendas", "nome", "Minh")).to eq([primeiro_cliente])
      end
    end

    it 'deve ordenar busca por ordem alfabética' do
      primeiro_cliente = FactoryGirl.create(:cliente, nome: 'Thales Miguel')
      segundo_cliente = FactoryGirl.create(:cliente, nome: 'Thales Martinez')
      expect(Cliente.busca_por_campo("nome", "Thales")).to eq([segundo_cliente, primeiro_cliente])
    end
  end

  describe 'associações' do

    let(:cliente) { FactoryGirl.create(:cliente) }
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }

    it 'has_many Enderecos' do
      primeiro_endereco = FactoryGirl.create(:endereco, cidade: cidade, cliente: cliente)
      segundo_endereco = FactoryGirl.create(:endereco, primario: false, cidade: cidade, cliente: cliente)
      expect(cliente.enderecos).to eq([primeiro_endereco, segundo_endereco])
    end

    it 'has_many Telefones' do
      primerio_telefone = FactoryGirl.create(:telefone, cliente: cliente)
      segundo_telefone = FactoryGirl.create(:telefone, cliente: cliente)
      expect(cliente.telefones).to eq([primerio_telefone, segundo_telefone])
    end

    it 'has_many Emails' do
      primeiro_email = FactoryGirl.create(:email, cliente: cliente)
      segundo_email = FactoryGirl.create(:email, cliente: cliente)
      expect(cliente.emails).to eq([primeiro_email, segundo_email])
    end

    it 'has_many Fazendas' do
      primeira_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      segunda_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      expect(cliente.fazendas).to eq([primeira_fazenda, segunda_fazenda])
    end

    it 'has_many ClienteBancos' do
      banco = FactoryGirl.create(:banco)
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = FactoryGirl.create(:cliente_banco, primario: false, banco: banco, cidade: cidade, cliente: cliente)
      expect(cliente.cliente_bancos).to eq([primeiro_cliente_banco, segundo_cliente_banco])
    end

    it 'has_many Referências' do
      primeira_referencia = FactoryGirl.create(:referencia, cliente: cliente)
      segunda_referencia = FactoryGirl.create(:referencia, cliente: cliente)
      expect(cliente.referencias).to eq([primeira_referencia, segunda_referencia])
    end

    it 'has_many Autorizados a Lançar' do
      primeiro_autorizado_a_lancar = FactoryGirl.create(:lancar_autorizado, cliente: cliente)
      segundo_autorizado_a_lancar = FactoryGirl.create(:lancar_autorizado, cliente: cliente)
      expect(cliente.lancar_autorizados).to eq([primeiro_autorizado_a_lancar, segundo_autorizado_a_lancar])
    end

    it 'has_many Tags' do
      primeira_tag = FactoryGirl.create(:tag, cliente: cliente)
      segunda_tag = FactoryGirl.create(:tag, cliente: cliente)
      expect(cliente.tags).to eq([primeira_tag, segunda_tag])
    end

    it 'has_many Empresas' do
      primeira_empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      segunda_empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      expect(cliente.empresas).to eq([primeira_empresa, segunda_empresa])
    end

  end

  describe 'atributos' do
    it 'adiciona o usuário atual ao campo cadastrado_por'
  end
end
