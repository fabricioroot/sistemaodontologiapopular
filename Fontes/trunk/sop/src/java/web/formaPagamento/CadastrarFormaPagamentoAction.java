package web.formaPagamento;

import annotations.FormaPagamento;
import dao.FormaPagamentoDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.FormaPagamentoService;

/**
 *
 * @author Fabricio Reis
 */
public class CadastrarFormaPagamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHASALVAR = "falhaSalvar";
    private static final String FALHAVALIDAR = "falhaValidar";
    private static final String NOMEFORMAPAGAMENTOJAEXISTE = "nomeFormaPagamentoJaExiste";
    private static final String DESCRICAOFORMAPAGAMENTOJAEXISTE = "descricaoFormaPagamentoJaExiste";
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

        CadastrarFormaPagamentoActionForm formFormaPagamento = (CadastrarFormaPagamentoActionForm) form;

        FormaPagamentoDAO formaPagamentoDAO = new FormaPagamentoDAO();

        if ((formFormaPagamento.getNome().trim().isEmpty()) || (formFormaPagamento.getDescricao().trim().isEmpty()) || (formFormaPagamento.getTipo() == 'S')) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        if ((formFormaPagamento.getTipo() == 'A') && ((formFormaPagamento.getDesconto().toString().trim().isEmpty()) || (formFormaPagamento.getPisoParaDesconto().toString().trim().isEmpty()))) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        if ((formFormaPagamento.getTipo() == 'P') && (formFormaPagamento.getValorMinimoAPrazo().toString().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        try {
            // Verifica se existe cadastro com o mesmo nome digitado no formulario
            if (!formFormaPagamento.getNome().trim().isEmpty()) {
                if (!formaPagamentoDAO.validarNome(formFormaPagamento.getNome().trim())) {
                    return mapping.findForward(NOMEFORMAPAGAMENTOJAEXISTE);
                }
            }

            // Verifica se existe cadastro com a mesma descricao digitada no formulario
            if (!formFormaPagamento.getDescricao().trim().isEmpty()) {
                if (!formaPagamentoDAO.validarDescricao(formFormaPagamento.getDescricao().trim())) {
                    return mapping.findForward(DESCRICAOFORMAPAGAMENTOJAEXISTE);
                }
            }

        } catch (Exception e) {
            System.out.println("Falha ao validar dados unicos de forma de pagamento no banco de dados! Exception: " + e.getMessage());
            return mapping.findForward(FALHAVALIDAR);
        }

        FormaPagamento formaPagamento = new FormaPagamento();
        formaPagamento.setNome(formFormaPagamento.getNome().trim());
        formaPagamento.setDescricao(formFormaPagamento.getDescricao().trim());
        formaPagamento.setStatus(formFormaPagamento.getStatus());
        formaPagamento.setTipo(formFormaPagamento.getTipo());
        if(formFormaPagamento.getTipo() == 'A') {
            formaPagamento.setDesconto(formFormaPagamento.getDesconto());
            formaPagamento.setPisoParaDesconto(formFormaPagamento.getPisoParaDesconto());
        }
        else if(formFormaPagamento.getTipo() == 'P') {
            formaPagamento.setValorMinimoAPrazo(formFormaPagamento.getValorMinimoAPrazo());
        }

        Short id = FormaPagamentoService.salvar(formaPagamento);
        if(id != null) {
            System.out.println("Registro de FormaPagamento (ID = " + id + ") salvo com sucesso!");
            request.setAttribute("idFormaPagamento", id.toString()); // Usado em VisualizarFormaPagamentoAction
            request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarFormaPagamento.jsp
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao salvar registro de forma de pagamento no banco!");
            return mapping.findForward(FALHASALVAR);
        }
    }
}