package web.funcionario;

import annotations.Dentista;
import annotations.Funcionario;
import annotations.GrupoAcesso;
import dao.DentistaDAO;
import dao.FuncionarioDAO;
import java.util.ArrayList;
import java.util.Set;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class EditarFuncionarioAction extends org.apache.struts.action.Action {
    
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

        // Captura o id do funcionario que vem no request da pagina consultar funcionario quando clicado o botao editar funcionario
        String idFuncionario = "";
        if (request.getParameter("idFuncionario") != null) {
            idFuncionario = request.getParameter("idFuncionario");
        }

        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        Funcionario funcionario;
        DentistaDAO dentistaDAO = new DentistaDAO();
        Dentista dentista;
        try {
            if (!idFuncionario.equals("")) {
                // Busca informacoes do funcionario no banco
                funcionario = funcionarioDAO.consultarId(Integer.parseInt(idFuncionario));
                // Se for dentista coloca o objeto dentista no request
                if (funcionario.getCargo().equals("Dentista-Orcamento") || funcionario.getCargo().equals("Dentista-Tratamento")|| funcionario.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                    dentista = dentistaDAO.consultarId(Integer.parseInt(idFuncionario));
                    request.setAttribute("dentista", dentista);
                }
                else { // Senao coloca o objeto funcionario no request
                    request.setAttribute("funcionario", funcionario);
                }

                // Coloca em um ArrayList<String> os nomes dos grupos de acesso que o funcionario estah contido
                Set<GrupoAcesso> grupoAcessoSet = funcionario.getGrupoAcessoSet();
                ArrayList<String> nomesGrupoAcesso = new ArrayList<String>();
                if (grupoAcessoSet != null) {
                    Iterator iterator = grupoAcessoSet.iterator();
                    while (iterator.hasNext()) {
                        nomesGrupoAcesso.add(((GrupoAcesso) iterator.next()).getNome());
                    }
                }

                // Coloca o objeto 'nomesGrupoAcesso' no request
                // Este objeto eh usado na editarFuncioanrio.jsp para carregar corretamente os check boxes dos grupos de acesso do funcionario
                if (!nomesGrupoAcesso.isEmpty()) {
                    request.setAttribute("nomesGrupoAcesso", nomesGrupoAcesso);
                }
            }
        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de funcionario no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}