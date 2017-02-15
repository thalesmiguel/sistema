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

    it 'busca cidade primário' do
      cliente = FactoryGirl.create(:cliente)
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      endereco = FactoryGirl.create(:endereco, cliente: cliente, cidade: cidade, primario: true)

      expect(cliente.cidade_primaria).to eq cidade
      expect(cliente.cidade_primaria("nome")).to eq cidade.nome
    end

    it 'retorna cidade nula caso não existam endereços cadastrados' do
      cliente = FactoryGirl.create(:cliente)

      expect(cliente.cidade_primaria).to eq ""
    end

    it 'busca estado primário' do
      cliente = FactoryGirl.create(:cliente)
      estado = FactoryGirl.create(:estado)
      cidade = FactoryGirl.create(:cidade, estado: estado)
      endereco = FactoryGirl.create(:endereco, cliente: cliente, cidade: cidade, primario: true)

      expect(cliente.estado_primario).to eq estado
      expect(cliente.estado_primario("sigla")).to eq estado.sigla
    end

    it 'retorna estado nulo caso não existam endereços cadastrados' do
      cliente = FactoryGirl.create(:cliente)

      expect(cliente.estado_primario).to eq ""
    end

    it 'busca por ocorrências no SERASA' do
      user = FactoryGirl.create(:user)
      cliente = FactoryGirl.create(:cliente)

      primeiro_alerta = FactoryGirl.create(:alerta, user: user, cliente: cliente, tipo: :serasa_incluído)
      primeiro_alerta = FactoryGirl.create(:alerta, user: user, cliente: cliente, tipo: :serasa_pendências)
      segundo_alerta = FactoryGirl.create(:alerta, user: user, cliente: cliente, tipo: :observação)
      expect(cliente.pendencias_no_serasa).to eq 2
    end

    context 'busca informações adicionais' do
      let(:user) { FactoryGirl.create(:user) }
      let(:cliente) { FactoryGirl.create(:cliente, ativo: true) }

      context 'Pendências no SERASA' do
        it 'apresenta informação se Alerta está ativo' do
          alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user, tipo: :serasa_incluído, ativo: true)
          alerta.reload
          expect(cliente.informacoes_adicionais).to include "serasa"
        end

        it 'não apresenta informação se Alerta está inativo' do
          alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user, tipo: :serasa_incluído, ativo: false)
          alerta.reload
          expect(cliente.informacoes_adicionais).to_not include "serasa"
        end
      end

      it 'apresenta cadastro ativo' do
        cliente.reload
        expect(cliente.informacoes_adicionais).to include "ativo"
      end
    end

  end

  describe 'associações' do

    let(:cliente) { FactoryGirl.create(:cliente) }
    let(:estado) { FactoryGirl.create(:estado) }
    let(:cidade) { FactoryGirl.create(:cidade, estado: estado) }
    let(:user) { FactoryGirl.create(:user) }

    it 'has_many Enderecos' do
      primeiro_endereco = FactoryGirl.create(:endereco, cidade: cidade, cliente: cliente)
      segundo_endereco = FactoryGirl.create(:endereco, primario: false, cidade: cidade, cliente: cliente)
      expect(cliente.enderecos).to eq([primeiro_endereco, segundo_endereco])
    end
    it 'apaga Enderecos quando é destruído' do
      endereco = FactoryGirl.create(:endereco, cidade: cidade, cliente: cliente)
      expect { cliente.destroy }.to change { Endereco.count }
    end

    it 'has_many Telefones' do
      primerio_telefone = FactoryGirl.create(:telefone, cliente: cliente)
      segundo_telefone = FactoryGirl.create(:telefone, cliente: cliente)
      expect(cliente.telefones).to eq([primerio_telefone, segundo_telefone])
    end
    it 'apaga Telefones quando é destruído' do
      telefone = FactoryGirl.create(:telefone, cliente: cliente)
      expect { cliente.destroy }.to change { Telefone.count }
    end

    it 'has_many Emails' do
      primeiro_email = FactoryGirl.create(:email, cliente: cliente)
      segundo_email = FactoryGirl.create(:email, cliente: cliente)
      expect(cliente.emails).to eq([primeiro_email, segundo_email])
    end
    it 'apaga Emails quando é destruído' do
      email = FactoryGirl.create(:email, cliente: cliente)
      expect { cliente.destroy }.to change { Email.count }
    end

    it 'has_many Fazendas' do
      primeira_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      segunda_fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      expect(cliente.fazendas).to eq([primeira_fazenda, segunda_fazenda])
    end
    it 'apaga Fazendas quando é destruído' do
      fazenda = FactoryGirl.create(:fazenda, cidade: cidade, cliente: cliente)
      expect { cliente.destroy }.to change { Fazenda.count }
    end

    it 'has_many ClienteBancos' do
      banco = FactoryGirl.create(:banco)
      primeiro_cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      segundo_cliente_banco = FactoryGirl.create(:cliente_banco, primario: false, banco: banco, cidade: cidade, cliente: cliente)
      expect(cliente.cliente_bancos).to eq([primeiro_cliente_banco, segundo_cliente_banco])
    end
    it 'apaga ClienteBancos quando é destruído' do
      banco = FactoryGirl.create(:banco)
      cliente_banco = FactoryGirl.create(:cliente_banco, banco: banco, cidade: cidade, cliente: cliente)
      expect { cliente.destroy }.to change { ClienteBanco.count }
    end

    it 'has_many Referências' do
      primeira_referencia = FactoryGirl.create(:referencia, cliente: cliente)
      segunda_referencia = FactoryGirl.create(:referencia, cliente: cliente)
      expect(cliente.referencias).to eq([primeira_referencia, segunda_referencia])
    end
    it 'apaga Referências quando é destruído' do
      referencia = FactoryGirl.create(:referencia, cliente: cliente)
      expect { cliente.destroy }.to change { Referencia.count }
    end

    it 'has_many Autorizados a Lançar' do
      primeiro_autorizado_a_lancar = FactoryGirl.create(:lancar_autorizado, cliente: cliente)
      segundo_autorizado_a_lancar = FactoryGirl.create(:lancar_autorizado, cliente: cliente)
      expect(cliente.lancar_autorizados).to eq([primeiro_autorizado_a_lancar, segundo_autorizado_a_lancar])
    end
    it 'apaga Autorizados a Lançar quando é destruído' do
      autorizado_a_lancar = FactoryGirl.create(:lancar_autorizado, cliente: cliente)
      expect { cliente.destroy }.to change { LancarAutorizado.count }
    end

    it 'has_many Tags' do
      primeira_tag = FactoryGirl.create(:tag, cliente: cliente)
      segunda_tag = FactoryGirl.create(:tag, cliente: cliente)
      expect(cliente.tags).to eq([primeira_tag, segunda_tag])
    end
    it 'apaga Tags quando é destruído' do
      tag = FactoryGirl.create(:tag, cliente: cliente)
      expect { cliente.destroy }.to change { Tag.count }
    end

    it 'has_many Empresas' do
      primeira_empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      segunda_empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      expect(cliente.empresas).to eq([primeira_empresa, segunda_empresa])
    end
    it 'apaga Empresas quando é destruído' do
      empresa = FactoryGirl.create(:empresa, cidade: cidade, cliente: cliente)
      expect { cliente.destroy }.to change { Empresa.count }
    end

    it 'has_many Alertas' do
      primeiro_alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user)
      segundo_alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user)
      expect(cliente.alertas).to eq([primeiro_alerta, segundo_alerta])
    end
    it 'apaga Alertas quando é destruído' do
      alerta = FactoryGirl.create(:alerta, cliente: cliente, user: user)
      expect { cliente.destroy }.to change { Alerta.count }
    end

    it 'has_many :promotor_leiloes, through LeilaoPromotores' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: cliente, leilao: primeiro_leilao)
      segundo_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: cliente, leilao: segundo_leilao)
      expect(cliente.promotor_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end
    it 'apaga LeilaoPromotores quando é destruído' do
      leilao = FactoryGirl.create(:leilao)
      leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: cliente, leilao: leilao)
      expect { cliente.destroy }.to change { LeilaoPromotor.count }
    end

    it 'has_many :convidado_leiloes, through LeilaoPromotores' do
      primeiro_leilao = FactoryGirl.create(:leilao)
      segundo_leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: cliente, leilao: primeiro_leilao)
      segundo_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: cliente, leilao: segundo_leilao)
      expect(cliente.convidado_leiloes).to eq([primeiro_leilao, segundo_leilao])
    end
    it 'apaga LeilaoPromotores quando é destruído' do
      leilao = FactoryGirl.create(:leilao)
      primeiro_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: cliente, leilao: leilao)
      expect { cliente.destroy }.to change { LeilaoConvidado.count }
    end

    it 'has_many PlanejamentoEscalas' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário')
      leilao = FactoryGirl.create(:leilao)
      primeira_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
      segunda_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
      expect(funcionario.planejamento_escalas).to eq [primeira_escala, segunda_escala]
    end
    it 'apaga PlanejamentoEscalas quando é destruído' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário')
      leilao = FactoryGirl.create(:leilao)
      escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
      expect { funcionario.destroy }.to change { PlanejamentoEscala.count }
    end

  end

  describe 'log' do

    describe 'gera log de' do
      let(:cliente) { FactoryGirl.create(:cliente) }

      it 'criação de Telefone' do
        expect(cliente.audits.count).to eq 1
      end

      it 'alteração de Telefone' do
        cliente.nome = "Novo nome"
        cliente.save
        expect(cliente.audits.count).to eq 2
      end

      it 'exclusão de Telefone' do
        cliente.destroy
        expect(cliente.audits.count).to eq 2
      end

    end
  end

end
