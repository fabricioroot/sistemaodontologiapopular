package web.grupoAcesso;

import annotations.GrupoAcesso;
import dao.GrupoAcessoDAO;
import java.util.ArrayList;
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
public class ConsultarGrupoAcessoAction extends org.apache.struts.action.Action {

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

        ConsultarGrupoAcessoActionForm formGrupoAcesso =  (ConsultarGrupoAcessoActionForm) form;

        GrupoAcessoDAO grupoAcessoDAO = new GrupoAcessoDAO();
        List<GrupoAcesso> resultado = new ArrayList<GrupoAcesso>();
        try {
            resultado = grupoAcessoDAO.consultarGrupos(formGrupoAcesso.getGrupoAcessoId());
            request.setAttribute("resultado", resultado);
        } catch (Exception e) {
            System.out.println("Falha ao consultar usuarios de um grupo de acesso no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}
