package web.caixa;

import annotations.Boca;
import annotations.Ficha;
import annotations.HistoricoBoca;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.BocaService;
import service.FichaService;
import service.HistoricoBocaService;
import service.StatusProcedimentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class LiberarProcedimentoBocaCompletaAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String SALDOINSUFICIENTE = "saldoInsuficiente";
    private static final String NAOEHREGISTRODEORCAMENTO = "naoEhRegistroDeOrcamento";
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

        // Captura o id da Boca do paciente vindo da pagina visualizarHistoricoBocaParaLiberarProcedimentos.jsp
        String idBoca = "";
        if (request.getParameter("idBoca") != null) {
            idBoca = request.getParameter("idBoca");
        }

        // Busca registro de Boca no banco com o idBoca capturado anteriormente e instancia objeto
        // O objeto encontrado tem informacoes do paciente
        Boca boca = BocaService.getBocaxPaciente(Integer.parseInt(idBoca));
        if (boca == null) {
            System.out.println("Registro de Boca (ID = " + idBoca + ") NAO encontrado em LiberarProcedimentoBocaCompletaAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Busca registro de Ficha no banco a partir do registro do paciente
        // O objeto encontrado tem informacoes do paciente
        Ficha ficha = FichaService.getFicha(boca.getPaciente());
        if (ficha == null) {
            System.out.println("Registro de Ficha do paciente (ID = " + boca.getPaciente().getId() + ") NAO encontrado em LiberarProcedimentoBocaCompletaAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica o saldo do paciente
        if (ficha.getSaldo() <= Double.parseDouble("0")) {
            return mapping.findForward(SALDOINSUFICIENTE);
        }

        // Captura o id da historicoBoca vindo da pagina visualizarHistoricoBocaParaLiberarProcedimentos.jsp
        String idHistoricoBoca = "";
        if (request.getParameter("idHistoricoBoca") != null) {
            idHistoricoBoca = request.getParameter("idHistoricoBoca");
        }

        // Busca registro de historicoBoca no banco com o idHistoricoBoca capturado anteriormente e instancia objeto
        HistoricoBoca historicoBoca = HistoricoBocaService.getHistoricoBoca(Integer.parseInt(idHistoricoBoca));
        if (historicoBoca == null) {
            System.out.println("Registro de HistoricoBoca (ID = " + idHistoricoBoca + ") NAO encontrado em LiberarProcedimentoBocaCompletaAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o registro a ser excluido nao estah com status orcado
        if (!historicoBoca.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
            return mapping.findForward(NAOEHREGISTRODEORCAMENTO);
        }
        else {
            // Verifica se o saldo do paciente eh suficiente
            if (ficha.getSaldo() < historicoBoca.getValorCobrado()) {
                return mapping.findForward(SALDOINSUFICIENTE);
            }
            else {
                // Deduz saldo...
                ficha.setSaldo(ficha.getSaldo() - historicoBoca.getValorCobrado());
                if (FichaService.atualizar(ficha)) {
                    System.out.println("Registro de Ficha (ID = " + ficha.getId() + ") atualizado com sucesso em LiberarProcedimentoBocaCompletaAction");
                }
                else {
                    System.out.println("Falha ao atualizar registro de Ficha (ID = " + ficha.getId() + ") em LiberarProcedimentoBocaCompletaAction");
                    return mapping.findForward(FALHAATUALIZAR);
                }

                // Atualiza a data do historicoBoca
                historicoBoca.setDataHora(new Date());
                // Atualiza o status do historicoBoca
                historicoBoca.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoPago());
                // Atualiza o registro de historicoBoca no banco
                if (!HistoricoBocaService.atualizar(historicoBoca)) {
                    System.out.println("Falha ao atualizar registro de historicoBoca (ID = " + idHistoricoBoca + ") em LiberarProcedimentoBocaCompletaAction");
                    return mapping.findForward(FALHAATUALIZAR);
                }
                else {
                    return mapping.findForward(SUCESSO);
                }
            }
        }
    }
}