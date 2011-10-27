package web.chequeBancario;

import annotations.ChequeBancario;
import dao.ChequeBancarioDAO;
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
public class ConsultarChequeBancarioAction extends org.apache.struts.action.Action {

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

        ConsultarChequeBancarioActionForm formChequeBancario =  (ConsultarChequeBancarioActionForm) form;

        Integer opcao = formChequeBancario.getOpcao();
        ChequeBancarioDAO chequeBancarioDAO = new ChequeBancarioDAO();
        List<ChequeBancario> resultado;
        try {
            switch (opcao) {
                case 0: // Pesquisa pelo numero
                    resultado = chequeBancarioDAO.consultarNumero(formChequeBancario.getNumero().trim());
                    break;
                case 1: // Pesquisa pelo periodo (inicio e fim de dataParaDepositar)
                    if (!formChequeBancario.getDataInicio().trim().isEmpty()) {
                        Date dataInicio = new Date();
                        Date dataFim = new Date();
                        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
                        try {
                            dataInicio = formatador.parse(formChequeBancario.getDataInicio().trim());
                            if (!formChequeBancario.getDataFim().trim().isEmpty()) {
                                dataFim = formatador.parse(formChequeBancario.getDataFim().trim());
                            }
                        } catch (Exception e) {
                            System.out.println("Falha ao formatar a data para depositar de cheque bancario em ConsultarChequeBancarioAction! Exception: " + e.getMessage());
                            return mapping.findForward(FALHAFORMATARDATA);
                        }
                        resultado = chequeBancarioDAO.consultarPeriodoDataParaDepositar(dataInicio, dataFim);
                    }
                    else {
                        resultado = chequeBancarioDAO.consultarNumero("");
                    }
                    break;
                default:
                    System.out.println("Opcao de pesquisa em consultar chequeBancario nao encontrada!");
                    resultado = null;
            }
            request.setAttribute("resultado", resultado);
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de chequeBancario no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}
