package web.atendimentoOrcamento;

import annotations.Paciente;
import service.PacienteService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio P. Reis
 */
public class ImprimirOrcamentoAction extends org.apache.struts.action.Action {

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

        // Captura o id do paciente que vem da pagina consultarPaciente.jsp ou atenderAtendimentoOrcamento.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }

        Paciente paciente = PacienteService.getPaciente(Integer.getInteger(idPaciente));

        if (paciente == null) {
            System.out.println("Registro de Paciente com ID: " + idPaciente + " NAO encontrado em ImprimirOrcamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        request.setAttribute("paciente", paciente);
        return mapping.findForward(SUCESSO);
    }
}