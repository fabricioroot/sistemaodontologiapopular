package web.filaAtendimentoOrcamento;

import annotations.AtendimentoOrcamento;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoOrcamentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class ConsultarFilaAtendimentoOrcamentoEmAtendimentoAction extends org.apache.struts.action.Action {

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

        // Busca atendimentos de orcamentos que estao em atendimento e cria objeto (Collection<AtendimentoOrcamento>)
        Collection<AtendimentoOrcamento> atendimentoOrcamentoCollection = AtendimentoOrcamentoService.getAtendimentosFilaAtendimentoOrcamentoEmAtendimento();
        if (atendimentoOrcamentoCollection == null) {
            System.out.println("Registros de atendimentos de orcamentos EM ATENDIMENTO NAO encontrados em ConsultarFilaAtendimentoOrcamentoEmAtendimentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        request.setAttribute("atendimentoOrcamentoCollection", atendimentoOrcamentoCollection);
        return mapping.findForward(SUCESSO);
    }
}