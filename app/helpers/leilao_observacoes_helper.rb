module LeilaoObservacoesHelper
  def btn_alterar_status
    if @leilao_observacao.ativo
      link_to "Inativar", leilao_altera_status_observacao_path(@leilao_observacao), method: 'put', remote: true, class: 'btn danger-color waves-effect waves-light m-r-5 btn-right',
            data: { confirm: t('.confirm', :default => t("helpers.links.confirm", default: 'Confirmar a inativação?')) } if can? :manage, :leilao_observacao
    else
      link_to "Ativar", leilao_altera_status_observacao_path(@leilao_observacao), method: 'put', remote: true, class: 'btn warning-color waves-effect waves-light m-r-5 btn-right',
            data: { confirm: t('.confirm', :default => t("helpers.links.confirm", default: 'Confirmar a ativação?')) } if can? :manage, :leilao_observacao
    end
  end

end
