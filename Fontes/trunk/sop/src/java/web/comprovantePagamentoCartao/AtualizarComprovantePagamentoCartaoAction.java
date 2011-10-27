package web.comprovantePagamentoCartao;

import annotations.Boca;
import annotations.ComprovantePagamentoCartao;
import annotations.Ficha;
import annotations.Pagamento;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ComprovantePagamentoCartaoService;
import service.FichaService;
import service.HistoricoBocaService;
import service.HistoricoDenteService;
import service.PagamentoService;

/**
 *
 * @author Fabricio Reis
 */
public class AtualizarComprovantePagamentoCartaoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
    private static final String SESSAOINVALIDA = "sessaoInvalida";

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // Controle de sessao
        if (request.getSession(false).getAttribute("status") == null) {
            return mapping.findForward(SESSAOINVALIDA);
        }
        else {
            if(!(Boolean)request.getSession(false).getAttribute("status")) {
                return mapping.findForward(SESSAOINVALIDA);
            }
        }

        AtualizarComprovantePagamentoCartaoActionForm formComprovantePagamentoCartao = (AtualizarComprovantePagamentoCartaoActionForm) form;

        if ((formComprovantePagamentoCartao.getBandeira().trim().isEmpty()) || (formComprovantePagamentoCartao.getCodigoAutorizacao().trim().isEmpty())
            || (formComprovantePagamentoCartao.getTipo() != 'D' && formComprovantePagamentoCartao.getTipo() != 'C')
            || (formComprovantePagamentoCartao.getTipo() == 'C' && formComprovantePagamentoCartao.getParcelas().toString().trim().isEmpty())
            || (formComprovantePagamentoCartao.getValor().toString().trim().isEmpty()) || (formComprovantePagamentoCartao.getValor() <= Double.parseDouble("0"))
            || (formComprovantePagamentoCartao.getId().toString().trim().isEmpty()) || (formComprovantePagamentoCartao.getStatus() == 'S')
            || (formComprovantePagamentoCartao.getNomePaciente().trim().isEmpty()) || (formComprovantePagamentoCartao.getIdPaciente().toString().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        ComprovantePagamentoCartao comprovantePagamentoCartao = new ComprovantePagamentoCartao();
        comprovantePagamentoCartao.setId(formComprovantePagamentoCartao.getId());
        comprovantePagamentoCartao.setNomePaciente(formComprovantePagamentoCartao.getNomePaciente());
        comprovantePagamentoCartao.setIdPaciente(formComprovantePagamentoCartao.getIdPaciente());
        comprovantePagamentoCartao.setBandeira(formComprovantePagamentoCartao.getBandeira().trim());
        comprovantePagamentoCartao.setTipo(formComprovantePagamentoCartao.getTipo());
        comprovantePagamentoCartao.setCodigoAutorizacao(formComprovantePagamentoCartao.getCodigoAutorizacao().trim());
        comprovantePagamentoCartao.setValor(formComprovantePagamentoCartao.getValor());
        if (formComprovantePagamentoCartao.getTipo() == 'C') {
            comprovantePagamentoCartao.setParcelas(formComprovantePagamentoCartao.getParcelas());
        }
        else if (formComprovantePagamentoCartao.getTipo() == 'D') {
            comprovantePagamentoCartao.setParcelas(Short.parseShort("1"));
        }

        Date dataPagamento = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            dataPagamento = formatador.parse(formComprovantePagamentoCartao.getDataPagamento());
        } catch (Exception e) {
            System.out.println("Falha ao formatar a data de pagamento com cartao ao atualizar registro! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }
        comprovantePagamentoCartao.setDataPagamento(dataPagamento);
        comprovantePagamentoCartao.setStatus(formComprovantePagamentoCartao.getStatus());
        comprovantePagamentoCartao.setPagamento(new Pagamento(formComprovantePagamentoCartao.getPagamentoId()));
        // Verifica se estah alterando o status do comprovantePagamentoCartao para 'Cancelado' (status = 'C')...
        // Se sim, atualiza o saldo da ficha do paciente e atualiza registro de pagamento com o comprovantePagamentoCartao cancelado
        if ((formComprovantePagamentoCartao.getStatus() == 'C') && formComprovantePagamentoCartao.getStatusAtual() != formComprovantePagamentoCartao.getStatus()) {
            Pagamento pagamento = PagamentoService.getFichaPaciente(formComprovantePagamentoCartao.getPagamentoId());
            // Identifica a boca do paciente associado ao comprovante de pagamento com cartao
            Boca boca = pagamento.getFicha().getPaciente().getBoca();
            // Identifica a ficha do paciente associado ao comprovante de pagamento com cartao
            Ficha ficha = pagamento.getFicha();

            // Atualiza o status de registros de 'historicoBoca' de 'liberado (pago)' para 'orcado'
            Double valorRestanteHistoricoBoca = HistoricoBocaService.acertoDevolucaoValor(formComprovantePagamentoCartao.getValor(), boca);
            Double valorRestanteHistoricoDente = Double.parseDouble("0");
            if (valorRestanteHistoricoBoca != null) {
                // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoBoca' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                ficha.setSaldo(ficha.getSaldo() + (formComprovantePagamentoCartao.getValor() - valorRestanteHistoricoBoca));
                // Verifica se ainda ha credito para fazer acerto
                if (valorRestanteHistoricoBoca > Double.parseDouble("0")) {
                    // Atualiza o status de registros de 'historicoDente' de 'liberado (pago)' para 'orcado'
                    valorRestanteHistoricoDente = HistoricoDenteService.acertoDevolucaoValor(valorRestanteHistoricoBoca, boca);
                    if (valorRestanteHistoricoDente != null) {
                        // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoDente' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                        ficha.setSaldo(ficha.getSaldo() + (valorRestanteHistoricoBoca - valorRestanteHistoricoDente));
                    }
                    else {
                        System.out.println("Falha ao atualizar registro(s) de historicoDente em AtualizarComprovantePagamentoCartaoAction");
                        return mapping.findForward(FALHAATUALIZAR);
                    }
                }
            }
            else {
                System.out.println("Falha ao atualizar registro(s) de historicoBoca em AtualizarComprovantePagamentoCartaoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            // Atualiza o saldo da ficha do paciente descontando o valor do comprovantePagamentoCartao
            ficha.setSaldo(ficha.getSaldo() - formComprovantePagamentoCartao.getValor());
            if (FichaService.atualizar(ficha)) {
                System.out.println("Registro de Ficha (ID = " + ficha.getId() + ") atualizado com sucesso em AtualizarComprovantePagamentoCartaoAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Ficha (ID = " + ficha.getId() + ") em AtualizarComprovantePagamentoCartaoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            // Atualiza o registro de pagamento descontando o valor do comprovantePagamentoCartao
            // TO DO: este trecho de codigo eh afetado caso seja inserido desconto para pagamento com cartao...
            // Eh preciso avaliacao
            pagamento.setValorEmCartao(pagamento.getValorEmCartao() - comprovantePagamentoCartao.getValor());
            pagamento.setValor(pagamento.getValor() - comprovantePagamentoCartao.getValor());
            pagamento.setValorFinal(pagamento.getValorFinal() - comprovantePagamentoCartao.getValor());
            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em AtualizarComprovantePagamentoCartaoAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em AtualizarComprovantePagamentoCartaoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }

        // Verifica se estah alterando o status do comprovantePagamentoCartao de 'Cancelado' para outro...
        // Se sim, atualiza o saldo da ficha do paciente e o registro de pagamento com o comprovantePagamentoCartao que estava cancelado
        if (formComprovantePagamentoCartao.getStatusAtual() == 'C' && formComprovantePagamentoCartao.getStatusAtual() != formComprovantePagamentoCartao.getStatus()) {
            Pagamento pagamento = PagamentoService.getFicha(formComprovantePagamentoCartao.getPagamentoId());
            // Atualiza o saldo da ficha do paciente imcrementando o valor do ComprovantePagamentoCartao que estava cancelado
            Ficha ficha = pagamento.getFicha();
            ficha.setSaldo(ficha.getSaldo() + formComprovantePagamentoCartao.getValor());
            if (FichaService.atualizar(ficha)) {
                System.out.println("Registro de Ficha (ID = " + ficha.getId() + ") atualizado com sucesso em AtualizarComprovantePagamentoCartaoAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Ficha (ID = " + ficha.getId() + ") em AtualizarComprovantePagamentoCartaoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
            // Atualiza o registro de pagamento imcrementando o valor do ComprovantePagamentoCartao que estava cancelado
            // TO DO: este trecho de codigo eh afetado caso seja inserido desconto para pagamento com cartao...
            // Eh preciso avaliacao
            pagamento.setValorEmCartao(pagamento.getValorEmCartao() + comprovantePagamentoCartao.getValor());
            pagamento.setValor(pagamento.getValor() + comprovantePagamentoCartao.getValor());
            pagamento.setValorFinal(pagamento.getValorFinal() + comprovantePagamentoCartao.getValor());
            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em AtualizarComprovantePagamentoCartaoAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em AtualizarComprovantePagamentoCartaoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }

        if(ComprovantePagamentoCartaoService.atualizar(comprovantePagamentoCartao)) {
            System.out.println("Registro de ComprovantePagamentoCartao (ID = " + comprovantePagamentoCartao.getId() + ") atualizado com sucesso!");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de ComprovantePagamentoCartao (ID = " + comprovantePagamentoCartao.getId() + ") no banco!");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}