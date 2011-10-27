package web.comprovantePagamentoCartao;

import annotations.ComprovantePagamentoCartao;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ComprovantePagamentoCartaoService;

/**
 *
 * @author Fabricio Reis
 */
public class RemoverComprovantePagamentoCartaoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAAOCAPTURARREGISTROSDECOMPROVANTESPAGAMENTOSCARTAO = "falhaAoCapturarRegistrosDeComprovantesPagamentosCartao";
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

        // Captura o codigo de autorizacao do comprovante de pagamento com cartao que vem da pagina registrarPagamento.jsp
        String codigoAutorizacao = "";
        if (request.getParameter("codigoAutorizacao") != null) {
            codigoAutorizacao = request.getParameter("codigoAutorizacao");
        }

        // Captura o Collection<ComprovantePagamentoCartao> da sessao
        // Se nao existir, cria um...
        Collection<ComprovantePagamentoCartao> comprovantePagamentoCartaoCollection;
        Collection<ComprovantePagamentoCartao> comprovantePagamentoCartaoCollectionAux = new ArrayList<ComprovantePagamentoCartao>();
        if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null) {
            comprovantePagamentoCartaoCollection = (Collection<ComprovantePagamentoCartao>)request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar");
            Iterator iterator = comprovantePagamentoCartaoCollection.iterator();
            ComprovantePagamentoCartao comprovantePagamentoCartaoAux;
            while (iterator.hasNext()) {
                comprovantePagamentoCartaoAux = (ComprovantePagamentoCartao)iterator.next();
                if (!codigoAutorizacao.equals(comprovantePagamentoCartaoAux.getCodigoAutorizacao())) {
                    comprovantePagamentoCartaoCollectionAux.add(comprovantePagamentoCartaoAux);
                }
            }
            // Recalcula o total dos comprovantes de pagamentos com cartao cadastrados e coloca o valor no request
            request.getSession(false).setAttribute("totalCartao", ComprovantePagamentoCartaoService.calcularTotal(comprovantePagamentoCartaoCollectionAux));

            if (comprovantePagamentoCartaoCollectionAux.isEmpty()) comprovantePagamentoCartaoCollectionAux = null;
            // Atualiza o objeto comprovantePagamentoCartaoCollectionPagar da sessao
            request.getSession(false).setAttribute("comprovantePagamentoCartaoCollectionPagar", comprovantePagamentoCartaoCollectionAux);
        }
        else {
            System.out.println("Falha ao buscar registros de comprovantes de pagamento com cartao na sessao. Comprovantes de pagamentos com cartao sao inseridos na sessao por CadastrarComprovantePagamentoCartaoAction. Situacao mapeada em RemoverComprovantePagamentoCartaoAction.");
            return mapping.findForward(FALHAAOCAPTURARREGISTROSDECOMPROVANTESPAGAMENTOSCARTAO);
        }
        return mapping.findForward(SUCESSO);
    }
}