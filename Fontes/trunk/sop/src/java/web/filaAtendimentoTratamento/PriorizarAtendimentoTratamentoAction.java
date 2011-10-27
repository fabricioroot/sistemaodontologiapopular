package web.filaAtendimentoTratamento;

import annotations.AtendimentoTratamento;
import annotations.Ficha;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoTratamentoService;
import service.FichaService;

/**
 *
 * @author Fabricio P. Reis
 */
public class PriorizarAtendimentoTratamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String ATENDIMENTOINICIADOOUREMOVIDODAFILA = "atendimentoIniciadoOuRemovidoDaFila";
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

        // Captura o id da ficha que vem da pagina consultarFilaAtendimentoTratamento
        String idFicha = "";
        if (request.getParameter("idFicha") != null) {
            idFicha = request.getParameter("idFicha");
        }

        // Busca registro de ficha no banco com o idFicha capturado que veio da pagina
        // consultarFilaAtendimentoTratamento e instancia objeto
        Ficha ficha = new Ficha();
        ficha = FichaService.getFicha(Integer.parseInt(idFicha));
        if (ficha == null) {
            System.out.println("Registro de Ficha com ID: " + idFicha + " NAO encontrado em PriorizarAtendimentoTratamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Busca atendimentoTratamento que nao foi iniciado nem priorizado
        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        atendimentoTratamento = AtendimentoTratamentoService.getAtendimentoTratamentoNaoIniciadoNaoPriorizado(ficha);
        if (atendimentoTratamento == null) {
            System.out.println("Registro AtendimentoTratamento NAO encontrado em PriorizarAtendimentoTratamentoAction");
            return mapping.findForward(ATENDIMENTOINICIADOOUREMOVIDODAFILA);
        }

        // Prioriza...
        atendimentoTratamento.setPrioridade(Boolean.TRUE);
        if (AtendimentoTratamentoService.atualizar(atendimentoTratamento)) {
            System.out.println("Registro de AtendimentoTratamento (ID = " + atendimentoTratamento.getId() + ") atualizado com sucesso em PriorizarAtendimentoTratamentoAction");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de AtendimentoTratamento (ID = " + atendimentoTratamento.getId() + ") em PriorizarAtendimentoTratamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}