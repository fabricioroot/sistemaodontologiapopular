package web.caixa;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class CancelarPagamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
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

        try {
            request.getSession(false).removeAttribute("fichaPagamento");
            request.getSession(false).removeAttribute("chequeBancarioCollectionPagar");
            request.getSession(false).removeAttribute("totalCheques");
            request.getSession(false).removeAttribute("comprovantePagamentoCartaoCollectionPagar");
            request.getSession(false).removeAttribute("totalCartao");
        } catch(Exception e) {
            System.out.println("Falha ao remover atributos da sessao em CancelarPagamentoAction. Exception: " + e.getCause());
            return mapping.findForward(FALHAATUALIZAR);
        }
        return mapping.findForward(SUCESSO);
    }
}