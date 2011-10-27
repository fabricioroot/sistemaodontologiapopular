package web.filaAtendimentoTratamento;

import annotations.AtendimentoTratamento;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoTratamentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class ConsultarFilaAtendimentoTratamentoEmAtendimentoAction extends org.apache.struts.action.Action {

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

        // Busca atendimentos de tratamento que estao em atendimento e cria objeto (Collection<AtendimentoTratamento>)
        Collection<AtendimentoTratamento> atendimentoTratamentoCollection = AtendimentoTratamentoService.getAtendimentosFilaAtendimentoTratamentoEmAtendimento();
        if (atendimentoTratamentoCollection == null) {
            System.out.println("Registros de atendimentos de tratamentos EM ATENDIMENTO NAO encontrados em ConsultarFilaAtendimentoTratamentoEmAtendimentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        request.setAttribute("atendimentoTratamentoCollection", atendimentoTratamentoCollection);
        return mapping.findForward(SUCESSO);
    }
}