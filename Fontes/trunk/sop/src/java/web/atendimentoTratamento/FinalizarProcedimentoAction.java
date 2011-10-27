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
public class FinalizarProcedimentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String NAOEHREGISTROEMTRATAMENTO = "naoEhRegistroEmTratamento";
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
            System.out.println("Registro de HistoricoDente com ID: " + idHistoricoDente + " NAO encontrado em FinalizarProcedimentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o registro tem status igual a "em tratamento"
        if (!historicoDente.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
            return mapping.findForward(NAOEHREGISTROEMTRATAMENTO);
        }
        else {
            // Atualiza a data do historicoDente
            historicoDente.setDataHora(new Date());
            // Atualiza o status do historicoDente
            historicoDente.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoFinalizado());
            // Atualiza o registro de historicoDente no banco
            if (!HistoricoDenteService.atualizar(historicoDente)) {
                System.out.println("Falha ao atualizar registro de historicoDente (ID = " + idHistoricoDente + ") em FinalizarProcedimentoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
            else {
                // Busca objeto dente com seu historico, atualiza suas faces e atualiza a base de dados
                Dente denteAux = DenteService.getHistoricoDente(historicoDente.getDente());

                // Tratativa para atualizar a face do dente de 'tratando' para 'finalizado'
                if (historicoDente.getFaceBucal()) {
                   denteAux.setFaceBucal(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo());
                }
                if (historicoDente.getFaceDistal()) {
                   denteAux.setFaceDistal(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo());
                }
                if (historicoDente.getFaceIncisal()) {
                   denteAux.setFaceIncisal(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo());
                }
                if (historicoDente.getFaceLingual()) {
                   denteAux.setFaceLingual(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo());
                }
                if (historicoDente.getFaceMesial()) {
                   denteAux.setFaceMesial(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo());
                }
                if (historicoDente.getRaiz()) {
                   denteAux.setRaiz(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo());
                }
                // Fim da tratativa

                Dente denteAux2 = DenteService.atualizarFaces(denteAux, false);
                if (!DenteService.atualizar(denteAux2)) {
                    System.out.println("Falha ao atualizar dente (ID = " + denteAux2.getId() + ") em FinalizarProcedimentoAction");
                    return mapping.findForward(FALHAATUALIZAR);
                }
                else {
                    return mapping.findForward(SUCESSO);
                }
            }
        }
    }
}