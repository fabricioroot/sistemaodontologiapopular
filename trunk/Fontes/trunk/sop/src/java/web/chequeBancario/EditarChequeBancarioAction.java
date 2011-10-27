package web.chequeBancario;

import annotations.ChequeBancario;
import dao.ChequeBancarioDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class EditarChequeBancarioAction extends org.apache.struts.action.Action {

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

        // Captura o id do cheque bancario que vem no request da pagina consultarChequeBancario.jsp quando clicado o botao editar
        String idChequeBancario = "";
        if (request.getParameter("idChequeBancario") != null) {
            idChequeBancario = request.getParameter("idChequeBancario");
        }

        ChequeBancarioDAO chequeBancarioDAO = new ChequeBancarioDAO();
        ChequeBancario chequeBancario;
        try {
            if (!idChequeBancario.equals("")) {
                // Busca informacoes do cheque bancario a partir do id
                chequeBancario = chequeBancarioDAO.consultarId(Integer.parseInt(idChequeBancario));
                // coloca o objeto 'chequeBancario' no request
                request.setAttribute("chequeBancario", chequeBancario);
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de chequeb bancario no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}