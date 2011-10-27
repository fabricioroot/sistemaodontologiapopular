package web.formaPagamento;

import annotations.FormaPagamento;
import dao.FormaPagamentoDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class EditarFormaPagamentoAction extends org.apache.struts.action.Action {

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

        // Captura o id da forma de pagamento que vem no request da pagina consultar forma pagamento quando clicado o botao editar forma pagamento
        String idFormaPagamento = "";
        if (request.getParameter("idFormaPagamento") != null) {
            idFormaPagamento = request.getParameter("idFormaPagamento");
        }

        FormaPagamentoDAO formaPagamentoDAO = new FormaPagamentoDAO();
        FormaPagamento resultado;
        try {
            if (!idFormaPagamento.equals("")) {
                // Busca informacoes da forma de pagamento no banco a partir do id
                resultado = formaPagamentoDAO.consultarId(Short.parseShort(idFormaPagamento));
                // coloca o objeto 'formaPagamento' no request
                request.setAttribute("formaPagamento", resultado);
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de forma de pagamento no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}