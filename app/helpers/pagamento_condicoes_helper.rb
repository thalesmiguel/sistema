module PagamentoCondicoesHelper
  def div_vencimento tipo
    if tipo == 'datas_diferenciadas'
      '<div class="input-field col s12 m4 parcela_vencimento">'.html_safe
    else
      '<div class="input-field col s12 m4 parcela_vencimento hidden">'.html_safe
    end
  end
end
