FactoryGirl.define do
  factory :taxa_automatica do
    tipo 1
    nome "MyString"
    nome_resumido "MyString"
    cobranca_por 1
    cobranca_lote_tipo 1
    cobrado_de (["vendidos", "defendidos", "retornados"])
    lote_a_cada 1
    lote_valor 1.25

    macho_a_cada 1
    macho_intervalo_inicio 1
    macho_intervalo_fim 1
    macho_valor 1.25
    macho_somente_sem_registro false

    femea_a_cada 1
    femea_intervalo_inicio 1
    femea_intervalo_fim 1
    femea_valor 1.25
    femea_somente_sem_registro false

    sem_sexo_a_cada 1
    sem_sexo_intervalo_inicio 1
    sem_sexo_intervalo_fim 1
    sem_sexo_valor 1.25
    sem_sexo_somente_sem_registro false
    
    leilao nil
  end
end
