package web.paciente;

import annotations.Boca;
import annotations.HistoricoBoca;
import annotations.Paciente;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.BocaService;
import service.HistoricoBocaService;

/**
 *
 * @author Fabricio Reis
 */
public class VisualizarHistoricoBocaAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
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

        // Captura o id do paciente que vem da pagina visualizarOdontograma.jsp, atenderAtendimentoOrcamento.jsp
        // ou atenderAtendimentoTratamento.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
            // Coloca o idPaciente na sessao para ser usado em sucessoIncluirProcedimento.jsp
            // ou para esse proprio action, apos excluir registro de historicoBoca
            request.getSession(false).setAttribute("idPaciente", idPaciente);
        }
        else if (request.getSession(false).getAttribute("idPaciente") != null) {
            idPaciente = (String) request.getSession(false).getAttribute("idPaciente");
        }
        Paciente paciente = new Paciente(Integer.parseInt(idPaciente));
        Boca boca = BocaService.getBoca(paciente);
        if (boca == null) {
            System.out.println("Registro de boca do paciente de ID: " + idPaciente + " NAO encontrado em VisualizarHistoricoPagamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        Collection<HistoricoBoca> historicoBocaCollectionOrdenadoDescData = new ArrayList<HistoricoBoca>();
        historicoBocaCollectionOrdenadoDescData = HistoricoBocaService.getHistoricoBocaOrdenadoDescData(boca);

        // Coloca o objeto 'boca' no request
        request.setAttribute("boca", boca);

        // Coloca o idBoca na sessao para ser usado em sucessoIncluirProcedimento.jsp
        request.getSession(false).setAttribute("idBoca", boca.getId().toString());

        // Coloca o objeto 'historicoBocaCollectionOrdenadoDescData' no request
        request.setAttribute("historicoBocaCollectionOrdenadoDescData", historicoBocaCollectionOrdenadoDescData);

        return mapping.findForward(SUCESSO);
    }
}