package web.chequeBancario;

import annotations.ChequeBancario;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ChequeBancarioService;

/**
 *
 * @author Fabricio Reis
 */
public class RemoverChequeBancarioAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAAOCAPTURARREGISTROSDECHEQUES = "falhaAoCapturarRegistrosDeCheques";
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

        // Captura o numero do cheque que vem da pagina registrarPagamento.jsp
        String numeroCheque = "";
        if (request.getParameter("numeroCheque") != null) {
            numeroCheque = request.getParameter("numeroCheque");
        }

        // Captura o Collection<ChequeBancario> da sessao
        // Se nao existir, cria um...
        Collection<ChequeBancario> chequeBancarioCollection;
        Collection<ChequeBancario> chequeBancarioCollectionAux = new ArrayList<ChequeBancario>();
        if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null) {
            chequeBancarioCollection = (Collection<ChequeBancario>)request.getSession(false).getAttribute("chequeBancarioCollectionPagar");
            Iterator iterator = chequeBancarioCollection.iterator();
            ChequeBancario chequeBancarioAux;
            while (iterator.hasNext()) {
                chequeBancarioAux = (ChequeBancario)iterator.next();
                if (!numeroCheque.equals(chequeBancarioAux.getNumero())) {
                    chequeBancarioCollectionAux.add(chequeBancarioAux);
                }
            }
            // Recalcula o total dos cheques cadastrados e coloca o valor no request
            request.getSession(false).setAttribute("totalCheques", ChequeBancarioService.calcularTotal(chequeBancarioCollectionAux));

            if (chequeBancarioCollectionAux.isEmpty()) chequeBancarioCollectionAux = null;
            // Atualiza o objeto chequeBancarioCollectionPagar da sessao
            request.getSession(false).setAttribute("chequeBancarioCollectionPagar", chequeBancarioCollectionAux);
        }
        else {
            System.out.println("Falha ao capturar registros de cheques na sessao. Cheques sao inseridos na sessao por CadastrarChequeBancarioAction. Situacao mapeada em RemoverChequeBancarioAction.");
            return mapping.findForward(FALHAAOCAPTURARREGISTROSDECHEQUES);
        }
        return mapping.findForward(SUCESSO);
    }
}