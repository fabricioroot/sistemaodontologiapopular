package web.atendimentoTratamento;

import annotations.Dente;
import annotations.HistoricoDente;
import java.util.Date;
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
public class IniciarProcedimentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String NAOEHREGISTROLIBERADO = "naoEhRegistroLiberado";
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

        // Captura o id da historicoDente vindo da pagina manipularProcedimentos.jsp
        String idHistoricoDente = "";
        if (request.getParameter("idHistoricoDente") != null) {
            idHistoricoDente = request.getParameter("idHistoricoDente");
        }

        // Busca registro de historicoDente no banco com o idHistoricoDente capturado anteriormente e instancia objeto
        HistoricoDente historicoDente = HistoricoDenteService.getHistoricoDente(Integer.parseInt(idHistoricoDente));
        if (historicoDente == null) {
            System.out.println("Registro de HistoricoDente com ID: " + idHistoricoDente + " NAO encontrado em IniciarProcedimentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o registro tem status igual a "liberado"
        if (!historicoDente.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoPago())) {
            return mapping.findForward(NAOEHREGISTROLIBERADO);
        }
        else {
            // Atualiza a data do historicoDente
            historicoDente.setDataHora(new Date());
            // Atualiza o status do historicoDente
            historicoDente.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoEmTratamento());
            // Atualiza o registro de historicoDente no banco
            if (!HistoricoDenteService.atualizar(historicoDente)) {
                System.out.println("Falha ao atualizar registro de historicoDente (ID = " + idHistoricoDente + ") em IniciarProcedimentoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
            else {
                // Busca objeto dente com seu historico, atualiza suas faces e atualiza a base de dados
                Dente denteAux = DenteService.getHistoricoDente(historicoDente.getDente());
                Dente denteAux2 = DenteService.atualizarFaces(denteAux, false);
                if (!DenteService.atualizar(denteAux2)) {
                    System.out.println("Falha ao atualizar dente (ID = " + denteAux2.getId() + ") em IniciarProcedimentoAction");
                    return mapping.findForward(FALHAATUALIZAR);
                }
                else {
                    return mapping.findForward(SUCESSO);
                }
            }
        }
    }
}