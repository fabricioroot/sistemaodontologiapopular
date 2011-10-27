package web.comprovantePagamentoCartao;

import annotations.ComprovantePagamentoCartao;
import dao.ComprovantePagamentoCartaoDAO;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class ConsultarComprovantePagamentoCartaoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
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

        ConsultarComprovantePagamentoCartaoActionForm formComprovantePagamentoCartao =  (ConsultarComprovantePagamentoCartaoActionForm) form;

        Integer opcao = formComprovantePagamentoCartao.getOpcao();
        ComprovantePagamentoCartaoDAO comprovantePagamentoCartaoDAO = new ComprovantePagamentoCartaoDAO();
        List<ComprovantePagamentoCartao> resultado;
        try {
            switch (opcao) {
                case 0: // Pesquisa pelo codigo de autorizacao
                    resultado = comprovantePagamentoCartaoDAO.consultarCodigoAutorizacao(formComprovantePagamentoCartao.getCodigoAutorizacao().trim());
                    break;
                case 1: // Pesquisa pelo periodo (inicio e fim de dataParaDepositar)
                    if (!formComprovantePagamentoCartao.getDataInicio().trim().isEmpty()) {
                        Date dataInicio = new Date();
                        Date dataFim = new Date();
                        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
                        try {
                            dataInicio = formatador.parse(formComprovantePagamentoCartao.getDataInicio().trim());
                            if (!formComprovantePagamentoCartao.getDataFim().trim().isEmpty()) {
                                dataFim = formatador.parse(formComprovantePagamentoCartao.getDataFim().trim());
                            }
                        } catch (Exception e) {
                            System.out.println("Falha ao formatar a data para depositar de cheque bancario em ConsultarChequeBancarioAction! Exception: " + e.getMessage());
                            return mapping.findForward(FALHAFORMATARDATA);
                        }
                        resultado = comprovantePagamentoCartaoDAO.consultarPeriodoDataPagamento(dataInicio, dataFim);
                    }
                    else {
                        resultado = comprovantePagamentoCartaoDAO.consultarCodigoAutorizacao("");
                    }
                    break;
                default:
                    System.out.println("Opcao de pesquisa em consultar comprovantePagamentoCartao nao encontrada!");
                    resultado = null;
            }
            request.setAttribute("resultado", resultado);
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de comprovante de pagamento com cartao no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}
