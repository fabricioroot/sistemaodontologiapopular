package web.funcionario;

import annotations.Dentista;
import annotations.Funcionario;
import dao.DentistaDAO;
import dao.FuncionarioDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class VisualizarFuncionarioAction extends org.apache.struts.action.Action {
    
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

        // Captura o id do funcionario que vem da pagina consultar funcionario
        String idFuncionario = "";
        if (request.getParameter("idFuncionario") != null) {
            idFuncionario = request.getParameter("idFuncionario");
        }
        else
        if (request.getAttribute("idFuncionario") != null) {
            idFuncionario = (String)request.getAttribute("idFuncionario");
        }

        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        Funcionario funcionario;
        DentistaDAO dentistaDAO = new DentistaDAO();
        Dentista dentista;
        try {
            if (!idFuncionario.equals("")) {
                // Busca informacoes do funcionario no banco a partir do id
                funcionario = funcionarioDAO.consultarId(Integer.parseInt(idFuncionario));
                // Se for dentista coloca o objeto 'dentista' no request
                if (funcionario.getCargo().equals("Dentista-Orcamento") || funcionario.getCargo().equals("Dentista-Tratamento") || funcionario.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                    dentista = dentistaDAO.consultarId(Integer.parseInt(idFuncionario));
                    request.setAttribute("dentista", dentista);
                }
                else { // Senao coloca o objeto 'funcionario' no request
                    request.setAttribute("funcionario", funcionario);
                }
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de funcionario no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}