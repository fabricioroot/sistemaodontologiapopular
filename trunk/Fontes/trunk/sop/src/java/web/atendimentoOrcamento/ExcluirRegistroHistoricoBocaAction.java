package web.atendimentoOrcamento;

import annotations.HistoricoBoca;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.HistoricoBocaService;
import service.StatusProcedimentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class ExcluirRegistroHistoricoBocaAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAAPAGAR = "falhaApagar";
    private static final String FALHACONSULTAR = "falhaConsultar";
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

        // Captura o id da historicoBoca vindo da pagina incluirProcedimentoBoca.jsp
        String idHistoricoBoca = "";
        if (request.getParameter("idHistoricoBoca") != null) {
            idHistoricoBoca = request.getParameter("idHistoricoBoca");
        }

        // Busca registro de historicoBoca no banco com o idHistoricoBoca capturado anteriormente e instancia objeto
        HistoricoBoca historicoBoca = HistoricoBocaService.getHistoricoBoca(Integer.parseInt(idHistoricoBoca));
        if (historicoBoca == null) {
            System.out.println("Registro de HistoricoBoca com ID: " + idHistoricoBoca + " NAO encontrado em ExcluirRegistroHistoricoBocaAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o registro a ser excluido eh de orcamento
        if (!historicoBoca.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
            return mapping.findForward(NAOEHREGISTRODEORCAMENTO);
        }
        else {
            // Exclui o registro de historicoBoca no banco
            if (!HistoricoBocaService.apagar(historicoBoca)) {
                System.out.println("Falha ao apagar registro de historicoBoca de ID: " + idHistoricoBoca);
                return mapping.findForward(FALHAAPAGAR);
            }
            else {
                return mapping.findForward(SUCESSO);
            }
        }
    }
}