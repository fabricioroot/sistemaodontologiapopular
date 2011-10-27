package web.comprovantePagamentoCartao;

import annotations.ComprovantePagamentoCartao;
import dao.ComprovantePagamentoCartaoDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class EditarComprovantePagamentoCartaoAction extends org.apache.struts.action.Action {

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

        // Captura o id do ComprovantePagamentoCartao que vem no request da pagina consultarComprovantePagamentoCartao.jsp quando clicado o botao editar
        String id = "";
        if (request.getParameter("id") != null) {
            id = request.getParameter("id");
        }

        ComprovantePagamentoCartaoDAO comprovantePagamentoCartaoDAO = new ComprovantePagamentoCartaoDAO();
        ComprovantePagamentoCartao comprovantePagamentoCartao;
        try {
            if (!id.equals("")) {
                // Busca informacoes do ComprovantePagamentoCartao a partir do id
                comprovantePagamentoCartao = comprovantePagamentoCartaoDAO.consultarId(Integer.parseInt(id));
                // coloca o objeto 'comprovantePagamentoCartao' no request
                request.setAttribute("comprovantePagamentoCartao", comprovantePagamentoCartao);
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de ComprovantePagamentoCartao no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}