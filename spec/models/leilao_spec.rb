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
    let(:leilao) { FactoryGirl.create(:leilao) }

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

    it 'has_many LeilaoObservacoes' do
      primeira_leilao_observacao = FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user)
      segunda_leilao_observacao = FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user)
      expect(leilao.leilao_observacoes).to eq([primeira_leilao_observacao, segunda_leilao_observacao])
    end
    it 'apaga LeilaoObservacoes quando é destruído' do
      leilao_observacao = FactoryGirl.create(:leilao_observacao, leilao: leilao, user: user)
      expect { leilao.destroy }.to change { LeilaoObservacao.count }
    end

    it 'has_many TaxaManuais' do
      primeira_taxa_manual = FactoryGirl.create(:taxa_manual, leilao: leilao)
      segunda_taxa_manual = FactoryGirl.create(:taxa_manual, leilao: leilao)
      expect(leilao.taxa_manuais).to eq([primeira_taxa_manual, segunda_taxa_manual])
    end
    it 'apaga TaxaManuais quando é destruído' do
      taxa_manual = FactoryGirl.create(:taxa_manual, leilao: leilao)
      expect { leilao.destroy }.to change { TaxaManual.count }
    end

    it 'has_many TaxaAutomaticas' do
      primeira_taxa_automatica = FactoryGirl.create(:taxa_automatica, leilao: leilao)
      segunda_taxa_automatica = FactoryGirl.create(:taxa_automatica, leilao: leilao)
      expect(leilao.taxa_automaticas).to eq([primeira_taxa_automatica, segunda_taxa_automatica])
    end
    it 'apaga TaxaAutomaticas quando é destruído' do
      taxa_automatica = FactoryGirl.create(:taxa_automatica, leilao: leilao)
      expect { leilao.destroy }.to change { TaxaAutomatica.count }
    end

    it 'has_many PlanejamentoEscalas' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário')
      primeira_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
      segunda_escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
      expect(leilao.planejamento_escalas).to eq [primeira_escala, segunda_escala]
    end
    it 'apaga PlanejamentoEscalas quando é destruído' do
      funcionario = FactoryGirl.create(:cliente, cadastro_tipo: 'funcionário')
      escala = FactoryGirl.create(:planejamento_escala, leilao: leilao, funcionario: funcionario)
      expect { leilao.destroy }.to change { PlanejamentoEscala.count }
    end

    it 'has_many PlanejamentoVeiculos' do
      veiculo = FactoryGirl.create(:veiculo, disponivel_viagem: true)
      primeira_veiculo = FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo)
      segunda_veiculo = FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo)
      expect(leilao.planejamento_veiculos).to eq [primeira_veiculo, segunda_veiculo]
    end
    it 'apaga PlanejamentoVeiculos quando é destruído' do
      veiculo = FactoryGirl.create(:veiculo, disponivel_viagem: true)
      veiculo = FactoryGirl.create(:planejamento_veiculo, leilao: leilao, veiculo: veiculo)
      expect { leilao.destroy }.to change { PlanejamentoVeiculo.count }
    end

    it 'has_one LeilaoEvento' do
      leilao_evento = FactoryGirl.create(:leilao_evento, leilao: leilao)
      expect(leilao.leilao_evento).to eq(leilao_evento)
    end

    it 'has_one LeilaoPadrao' do
      leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao)
      expect(leilao.leilao_padrao).to eq(leilao_padrao)
    end
    it 'apaga LeilaoPadrao quando é destruído' do
      leilao_padrao = FactoryGirl.create(:leilao_padrao, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoPadrao.count }
    end

    it 'has_one LeilaoComissao' do
      leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao)
      expect(leilao.leilao_comissao).to eq(leilao_comissao)
    end
    it 'apaga LeilaoComissao quando é destruído' do
      leilao_comissao = FactoryGirl.create(:leilao_comissao, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoComissao.count }
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
      primeiro_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: primeiro_cliente, leilao: leilao)
      segundo_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: segundo_cliente, leilao: leilao)
      expect(leilao.promotores).to eq([primeiro_cliente, segundo_cliente])
    end
    it 'apaga LeilaoPromotores quando é destruído' do
      cliente = FactoryGirl.create(:cliente)
      primeiro_leilao_promotor = FactoryGirl.create(:leilao_promotor, cliente: cliente, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoPromotor.count }
    end

    it 'has_many :convidados, through LeilaoConvidados' do
      primeiro_cliente = FactoryGirl.create(:cliente)
      segundo_cliente = FactoryGirl.create(:cliente)
      primeiro_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: primeiro_cliente, leilao: leilao)
      segundo_leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: segundo_cliente, leilao: leilao)
      expect(leilao.convidados).to eq([primeiro_cliente, segundo_cliente])
    end
    it 'apaga LeilaoConvidados quando é destruído' do
      cliente = FactoryGirl.create(:cliente)
      leilao_convidado = FactoryGirl.create(:leilao_convidado, cliente: cliente, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoConvidado.count }
    end

    it 'has_many :bandeiras, through LeilaoBandeiras' do
      primeira_bandeira = FactoryGirl.create(:bandeira)
      segunda_bandeira = FactoryGirl.create(:bandeira)
      primeiro_leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: primeira_bandeira, leilao: leilao)
      segundo_leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: segunda_bandeira, leilao: leilao)
      expect(leilao.bandeiras).to eq([primeira_bandeira, segunda_bandeira])
    end
    it 'apaga LeilaoBandeiras quando é destruído' do
      bandeira = FactoryGirl.create(:bandeira)
      leilao_bandeira = FactoryGirl.create(:leilao_bandeira, bandeira: bandeira, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoBandeira.count }
    end

    it 'has_many :canais, through LeilaoCanais' do
      primeiro_canal = FactoryGirl.create(:canal)
      segundo_canal = FactoryGirl.create(:canal)
      primeiro_leilao_canal = FactoryGirl.create(:leilao_canal, canal: primeiro_canal, leilao: leilao)
      segundo_leilao_canal = FactoryGirl.create(:leilao_canal, canal: segundo_canal, leilao: leilao)
      expect(leilao.canais).to eq([primeiro_canal, segundo_canal])
    end
    it 'apaga LeilaoCanais quando é destruído' do
      canal = FactoryGirl.create(:canal)
      primeiro_leilao_canal = FactoryGirl.create(:leilao_canal, canal: canal, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoCanal.count }
    end

    it 'has_many :racas, through LeilaoRacas' do
      primeira_raca = FactoryGirl.create(:raca)
      segunda_raca = FactoryGirl.create(:raca)
      primeiro_leilao_raca = FactoryGirl.create(:leilao_raca, raca: primeira_raca, leilao: leilao)
      segundo_leilao_raca = FactoryGirl.create(:leilao_raca, raca: segunda_raca, leilao: leilao)
      expect(leilao.racas).to eq([primeira_raca, segunda_raca])
    end
    it 'apaga LeilaoRacas quando é destruído' do
      raca = FactoryGirl.create(:raca)
      primeiro_leilao_raca = FactoryGirl.create(:leilao_raca, raca: raca, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoRaca.count }
    end

    it 'has_many :patrocinadores, through LeilaoPatrocinadores' do
      primeiro_patrocinador = FactoryGirl.create(:patrocinador)
      segundo_patrocinador = FactoryGirl.create(:patrocinador)
      primeiro_leilao_patrocinador = FactoryGirl.create(:leilao_patrocinador, patrocinador: primeiro_patrocinador, leilao: leilao)
      segundo_leilao_patrocinador = FactoryGirl.create(:leilao_patrocinador, patrocinador: segundo_patrocinador, leilao: leilao)
      expect(leilao.patrocinadores).to eq([primeiro_patrocinador, segundo_patrocinador])
    end
    it 'apaga LeilaoPatrocinadores quando é destruído' do
      patrocinador = FactoryGirl.create(:patrocinador)
      leilao_patrocinador = FactoryGirl.create(:leilao_patrocinador, patrocinador: patrocinador, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoPatrocinador.count }
    end

    it 'has_many :assessorias, through LeilaoAssessorias' do
      primeira_assessoria = FactoryGirl.create(:assessoria)
      segunda_assessoria = FactoryGirl.create(:assessoria)
      primeiro_leilao_assessoria = FactoryGirl.create(:leilao_assessoria, assessoria: primeira_assessoria, leilao: leilao)
      segundo_leilao_assessoria = FactoryGirl.create(:leilao_assessoria, assessoria: segunda_assessoria, leilao: leilao)
      expect(leilao.assessorias).to eq([primeira_assessoria, segunda_assessoria])
    end
    it 'apaga LeilaoPatrocinadores quando é destruído' do
      assessoria = FactoryGirl.create(:assessoria)
      leilao_assessoria = FactoryGirl.create(:leilao_assessoria, assessoria: assessoria, leilao: leilao)
      expect { leilao.destroy }.to change { LeilaoAssessoria.count }
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
