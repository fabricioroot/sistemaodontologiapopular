package web.procedimento;

import annotations.Procedimento;
import dao.ProcedimentoDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class VisualizarProcedimentoAction extends org.apache.struts.action.Action {

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

        // Captura o id do procedimento que vem da pagina consultarProcedimento.jsp
        String idProcedimento = "";
        if (request.getParameter("idProcedimento") != null) {
            idProcedimento = request.getParameter("idProcedimento");
        }
        else
        if (request.getAttribute("idProcedimento") != null) {
            idProcedimento = (String)request.getAttribute("idProcedimento");
        }

        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();
        Procedimento procedimento;
        try {
            if (!idProcedimento.equals("")) {
                // Busca informacoes do procedimento no banco a partir do id
                procedimento = procedimentoDAO.consultarId(Short.parseShort(idProcedimento));
                // coloca o objeto 'procedimento' no request
                request.setAttribute("procedimento", procedimento);
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de procedimento no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}