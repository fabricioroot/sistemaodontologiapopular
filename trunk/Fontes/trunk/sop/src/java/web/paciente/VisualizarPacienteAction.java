package web.paciente;

import annotations.Paciente;
import dao.PacienteDAO;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class VisualizarPacienteAction extends org.apache.struts.action.Action {
    
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

        // Captura o id do paciente que vem da pagina consultar paciente
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }
        else
        if (request.getAttribute("idPaciente") != null) {
            idPaciente = (String)request.getAttribute("idPaciente");
        }

        PacienteDAO pacienteDAO = new PacienteDAO();
        List<Paciente> resultado = new ArrayList();
        try {
            if (!idPaciente.equals("")) {
                // Busca informacoes do paciente no banco a partir do id
                resultado.add(pacienteDAO.consultarId(Integer.parseInt(idPaciente)).get(0));
                // Coloca o objeto 'paciente' no request
                request.setAttribute("paciente", resultado.get(0));
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de paciente no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}