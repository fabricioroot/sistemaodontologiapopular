package web.comprovantePagamentoCartao;

import annotations.ComprovantePagamentoCartao;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
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
public class CadastrarComprovantePagamentoCartaoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
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

        CadastrarComprovantePagamentoCartaoActionForm formComprovantePagamentoCartao = (CadastrarComprovantePagamentoCartaoActionForm) form;

        if ((formComprovantePagamentoCartao.getBandeira().trim().isEmpty()) || (formComprovantePagamentoCartao.getCodigoAutorizacao().trim().isEmpty())
            || (formComprovantePagamentoCartao.getTipo() != 'D' && formComprovantePagamentoCartao.getTipo() != 'C')
            || (formComprovantePagamentoCartao.getTipo() == 'C' && formComprovantePagamentoCartao.getParcelas().toString().trim().isEmpty())
            || (formComprovantePagamentoCartao.getValor().toString().trim().isEmpty()) || (formComprovantePagamentoCartao.getValor() <= Double.parseDouble("0"))) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        // Captura o Collection<ComprovantePagamentoCartao> da sessao
        Collection<ComprovantePagamentoCartao> comprovantePagamentoCartaoCollection = new ArrayList<ComprovantePagamentoCartao>();
        if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null) {
            comprovantePagamentoCartaoCollection = (Collection<ComprovantePagamentoCartao>)request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar");
        }

        // Verifica se o registro ja nao foi incluido
        if (!comprovantePagamentoCartaoCollection.isEmpty()) {
            ComprovantePagamentoCartao comprovantePagamentoCartaoAux;
            Iterator iterator = comprovantePagamentoCartaoCollection.iterator();
            while (iterator.hasNext()) {
                comprovantePagamentoCartaoAux = (ComprovantePagamentoCartao) iterator.next();
                if (comprovantePagamentoCartaoAux.getCodigoAutorizacao().equals(formComprovantePagamentoCartao.getCodigoAutorizacao().trim())) {
                    System.out.println("Registro de comprovante de pagamento com cartao ja incluido na sessao! Excecao mapeada em CadastrarComprovantePagamentoCartaoAction.");
                    return mapping.findForward(SUCESSO);
                }
            }
        }

        ComprovantePagamentoCartao comprovantePagamentoCartao = new ComprovantePagamentoCartao();
        comprovantePagamentoCartao.setBandeira(formComprovantePagamentoCartao.getBandeira().trim());
        comprovantePagamentoCartao.setTipo(formComprovantePagamentoCartao.getTipo());
        comprovantePagamentoCartao.setCodigoAutorizacao(formComprovantePagamentoCartao.getCodigoAutorizacao().trim());
        comprovantePagamentoCartao.setValor(formComprovantePagamentoCartao.getValor());
        if (formComprovantePagamentoCartao.getTipo() == 'C') {
            comprovantePagamentoCartao.setParcelas(formComprovantePagamentoCartao.getParcelas());
        }
        else if (formComprovantePagamentoCartao.getTipo() == 'D') {
            comprovantePagamentoCartao.setParcelas(Short.parseShort("1"));
        }
        comprovantePagamentoCartao.setDataPagamento(new Date());
        comprovantePagamentoCartao.setStatus('N'); // Status marcado como 'Nao checado'

        // Adiciona registro no Collection<ComprovantePagamentoCartao> criado / capturado
        comprovantePagamentoCartaoCollection.add(comprovantePagamentoCartao);

        // Atualiza / Coloca comprovantePagamentoCartaoCollection na sessao
        request.getSession(false).setAttribute("comprovantePagamentoCartaoCollectionPagar", comprovantePagamentoCartaoCollection);

        // Calcula o total dos pagamentos em cartao cadastrados e coloca o valor no request
        request.getSession(false).setAttribute("totalCartao", ComprovantePagamentoCartaoService.calcularTotal(comprovantePagamentoCartaoCollection));

        return mapping.findForward(SUCESSO);
    }
}