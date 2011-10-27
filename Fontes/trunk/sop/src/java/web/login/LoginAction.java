package web.login;

import annotations.Funcionario;
import dao.FuncionarioDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio P. Reis
 */
public class LoginAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String NOMEDEUSUARIOOUSENHAINVALIDO = "nomeDeUsuarioOuSenhaInvalido";
    private static final String SENHAINVALIDA = "senhaInvalida";
    private static final String FALHAVALIDARUSUARIO = "falhaValidarUsuario";
    private static final String FALHACONSULTARUSUARIO = "falhaConsultarUsuario";
    private static final String FALHAREGISTRARUSUARIONASESSAO = "falhaRegistrarUsuarioNaSessao";

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

        LoginActionForm loginActionForm = (LoginActionForm) form;
        String nomeDeUsuario = loginActionForm.getNomeDeUsuario().trim();
        String senha = loginActionForm.getSenha().trim();

        if ((nomeDeUsuario == null) || (nomeDeUsuario.trim().isEmpty())
            || (senha == null) || (senha.trim().isEmpty())) {
            return mapping.findForward(NOMEDEUSUARIOOUSENHAINVALIDO);
        }

        Funcionario funcionario = new Funcionario();
        funcionario.setNomeDeUsuario(nomeDeUsuario);
        funcionario.setSenha(senha);

        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        try {
            funcionario = funcionarioDAO.validarLogin(funcionario); // Verifica cadastro no sistema a partir de user e senha
                                                                    // retornando NULL ou o objeto encontrado
        } catch (Exception e) {
            System.out.println("Falha ao validar usuario e senha no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHAVALIDARUSUARIO);
        }

        if (funcionario != null) {
            try {
                request.getSession(true).setAttribute("status", true); // Atributo de sessao usado para controlar a sessao do usuario
                request.getSession(false).setAttribute("funcionarioLogado", funcionario); // Coloca o objeto funcionario na sessao
                return mapping.findForward(SUCESSO);
            } catch (Exception e) {
                System.out.println("Falha ao registrar usuario na sessao! Exception: " + e.getMessage());
                return mapping.findForward(FALHAREGISTRARUSUARIONASESSAO);
            }
        } else {
            request.getSession(true).setAttribute("status", false);
            try {
                funcionario = funcionarioDAO.consultarNomeDeUsuario(nomeDeUsuario);
                if (funcionario != null) {
                    request.setAttribute("funcionario", funcionario);
                    return mapping.findForward(SENHAINVALIDA);
                }
                else
                    return mapping.findForward(NOMEDEUSUARIOOUSENHAINVALIDO);
            } catch (Exception e) {
                System.out.println("Falha ao consultar usuario no banco! Exception: " + e.getMessage());
                return mapping.findForward(FALHACONSULTARUSUARIO);
            }
        }
    }
}
