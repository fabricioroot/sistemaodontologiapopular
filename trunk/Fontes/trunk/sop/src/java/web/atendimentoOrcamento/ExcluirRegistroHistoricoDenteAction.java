package web.atendimentoOrcamento;

import annotations.Dente;
import annotations.HistoricoDente;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.DenteService;
import service.HistoricoDenteService;
import service.StatusProcedimentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class ExcluirRegistroHistoricoDenteAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAAPAGAR = "falhaApagar";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String NAOEHREGISTRODEORCAMENTO = "naoEhRegistroDeOrcamento";
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

        // Captura o id da historicodente vindo da pagina incluirProcedimento.jsp
        String idHistoricoDente = "";
        if (request.getParameter("idHistoricoDente") != null) {
            idHistoricoDente = request.getParameter("idHistoricoDente");
        }

        // Busca registro de historicoDente no banco com o idHistoricoDente capturado anteriormente e instancia objeto
        HistoricoDente historicoDente = HistoricoDenteService.getHistoricoDente(Integer.parseInt(idHistoricoDente));
        if (historicoDente == null) {
            System.out.println("Registro de HistoricoDente com ID: " + idHistoricoDente + " NAO encontrado em ExcluirRegistroHistoricoDenteAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o registro a ser excluido eh de orcamento
        if (!historicoDente.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
            return mapping.findForward(NAOEHREGISTRODEORCAMENTO);
        }
        else {
            // Exclui o registro de historicoDente no banco
            if (!HistoricoDenteService.apagar(historicoDente)) {
                System.out.println("Falha ao apagar registro de historicoDente de ID: " + idHistoricoDente);
                return mapping.findForward(FALHAAPAGAR);
            }

            // Atualiza as faces do dente
            Dente dente = DenteService.getHistoricoDente(new Dente(historicoDente.getDente().getId()));
            dente = DenteService.atualizarFaces(dente, true);

            // Atualiza o registro do dente
            if(DenteService.atualizar(dente)) {
                System.out.println("Registro de Dente atualizado com sucesso em ExcluirRegistroHistoricoDenteAction");
                return mapping.findForward(SUCESSO);
            }
            else {
                System.out.println("Falha ao atualizar registro de Dente em ExcluirRegistroHistoricoDenteAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
    }
}