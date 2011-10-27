package web.caixa;

import annotations.Ficha;
import annotations.Paciente;
import annotations.Pagamento;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.FichaService;
import service.HistoricoBocaService;
import service.HistoricoDenteService;
import service.PagamentoService;

/**
 *
 * @author Fabricio Reis
 */
public class RegistrarDevolucaoDinheiroAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String SALDOINSUFICIENTE = "saldoInsuficiente";
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

        Ficha ficha = null;
        Paciente paciente = null;
        // Captura o id do paciente que vem da pagina devolverDinheiro.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
            paciente = new Paciente(Integer.parseInt(idPaciente));
            ficha = FichaService.getFicha(paciente);
        }
        if (ficha == null) {
            System.out.println("Registro de Ficha de Paciente de ID = " + idPaciente + " NAO encontrado em RegistrarDevolucaoDinheiroAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Busca registro de pagamento a partir do id recebido da pagina devolverDinheiro.jsp e instancia objeto Pagamento
        Pagamento pagamento = null;
        String idPagamento = "";
        if (request.getParameter("idPagamento") != null) {
            idPagamento = request.getParameter("idPagamento");
            pagamento = PagamentoService.getPagamento(Integer.parseInt(idPagamento));
        }
        if (pagamento == null) {
            System.out.println("Falha ao buscar registros de Pagamento em RegistrarDevolucaoDinheiroAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Atualiza o status de registros de 'historicoBoca' de 'liberado (pago)' para 'orcado'
        Double valorRestanteHistoricoBoca = HistoricoBocaService.acertoDevolucaoValor(pagamento.getValorEmDinheiro(), ficha.getPaciente().getBoca());
        Double valorRestanteHistoricoDente = Double.parseDouble("0");
        if (valorRestanteHistoricoBoca != null) {
            // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoBoca' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
            ficha.setSaldo(ficha.getSaldo() + (pagamento.getValorEmDinheiro() - valorRestanteHistoricoBoca));
            // Verifica se ainda ha credito para fazer acerto
            if (valorRestanteHistoricoBoca > Double.parseDouble("0")) {
                // Atualiza o status de registros de 'historicoDente' de 'liberado (pago)' para 'orcado'
                valorRestanteHistoricoDente = HistoricoDenteService.acertoDevolucaoValor(valorRestanteHistoricoBoca, ficha.getPaciente().getBoca());
                if (valorRestanteHistoricoDente != null) {
                    // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoDente' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                    ficha.setSaldo(ficha.getSaldo() + (valorRestanteHistoricoBoca - valorRestanteHistoricoDente));
                }
                else {
                    System.out.println("Falha ao atualizar registro(s) de historicoDente em RegistrarDevolucaoDinheiroAction");
                    return mapping.findForward(FALHAATUALIZAR);
                }
            }
        }
        else {
            System.out.println("Falha ao atualizar registro(s) de historicoBoca em RegistrarDevolucaoDinheiroAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Verifica se apos ter feito acertos (troca de status 'liberado' para 'orcado')
        // o paciente tera saldo para o processo "devolucao dinheiro"
        if (ficha.getSaldo() < pagamento.getValorEmDinheiro()) {
            System.out.println("A Ficha de ID = " + ficha.getId() + " nao tem saldo suficiente para devolucao de dinheiro. Situacao mapeada em RegistrarDevolucaoDinheiroAction");
            return mapping.findForward(SALDOINSUFICIENTE);
        }

        // Atualiza o saldo da ficha do paciente descontando o valor em dinheiro do pagamento
        ficha.setSaldo(ficha.getSaldo() - pagamento.getValorEmDinheiro());
        if (FichaService.atualizar(ficha)) {
            System.out.println("Registro de Ficha (ID = " + ficha.getId() + ") atualizado com sucesso em RegistrarDevolucaoDinheiroAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Ficha (ID = " + ficha.getId() + ") em RegistrarDevolucaoDinheiroAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Atualiza o registro de pagamento descontando o valor em dinheiro do pagamento
        pagamento.setValor(pagamento.getValor() - pagamento.getValorEmDinheiro());
        pagamento.setValorFinal(pagamento.getValorFinal() - pagamento.getValorEmDinheiro());
        pagamento.setValorEmDinheiro(Double.parseDouble("0"));

        if (pagamento.getValorEmCartao() == Double.parseDouble("0") && pagamento.getValorEmCheque() == Double.parseDouble("0")) {
            if (PagamentoService.apagar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") apagado com sucesso em RegistrarDevolucaoDinheiroAction");
            }
            else {
                System.out.println("Falha ao apagar registro de Pagamento (ID = " + pagamento.getId() + ") em RegistrarDevolucaoDinheiroAction. Seguindo com tentativa de atualizacao...");
                // Tenta-se atualizar, pois o registro de pagamento pode ter registro de cheque e/ou cartao associado a ele...
                if (PagamentoService.atualizar(pagamento)) {
                    System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em RegistrarDevolucaoDinheiroAction apos tentativa de exclusao");
                }
                else {
                    System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em RegistrarDevolucaoDinheiroAction apos tentativa de exclusao");
                    return mapping.findForward(FALHAATUALIZAR);
                }
            }
        }
        else {
            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em RegistrarDevolucaoDinheiroAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em RegistrarDevolucaoDinheiroAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }

        response.sendRedirect(request.getContextPath()+ "/app/caixa/actionListarPagamentos.do?idPaciente=" + request.getParameter("idPaciente"));
        return mapping.findForward(SUCESSO);
    }
}