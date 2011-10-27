package web.paciente;

import annotations.Dente;
import annotations.HistoricoDente;
import annotations.Boca;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.DenteService;
import service.HistoricoDenteService;

/**
 *
 * @author Fabricio Reis
 */
public class VisualizarHistoricoDenteAction extends org.apache.struts.action.Action {

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

        // Captura 'idBoca' que vem da pagina visualizarOdontograma.jsp, atenderAtendimentoOrcamento.jsp
        // ou atenderAtendimentoTratamento.jsp
        String idBoca = "";
        if (request.getParameter("idBoca") != null) {
            idBoca = request.getParameter("idBoca");
            // Coloca o idBoca na sessao para ser usado em sucessoIncluirProcedimento.jsp
            // ou para esse proprio action, apos excluir registro de historicoDente
            request.getSession(false).setAttribute("idBoca", idBoca);
        }
        else if (request.getSession(false).getAttribute("idBoca") != null) {
            idBoca = (String)request.getSession(false).getAttribute("idBoca");
        }

        Boca boca = new Boca(Integer.parseInt(idBoca));

        // Captura o id do dente que vem de uma das seguintes paginas visualizarOdontograma.jsp, atenderAtendimentoOrcamento.jsp
        // ou atenderAtendimentoTratamento.jsp
        String idDente = "";
        if (request.getParameter("idDente") != null) {
            idDente = request.getParameter("idDente");
            // Coloca o idDente na sessao para ser usado em sucessoIncluirProcedimento.jsp
            // ou para esse proprio action, apos excluir registro de historicoDente
            request.getSession(false).setAttribute("idDente", idDente);
        }
        else if (request.getSession(false).getAttribute("idDente") != null) {
            idDente = (String)request.getSession(false).getAttribute("idDente");
        }

        if (idDente.startsWith("S")) {
            System.out.println("Dente virgem! Busca dente na sessao...");
            String posicao = idDente.substring(1, 3);
            Dente dente = (Dente) request.getSession(false).getAttribute("dente" + posicao);
            request.setAttribute("dente", dente);
            return mapping.findForward(SUCESSO);
        }

        Dente dente = DenteService.getDente(boca, Integer.parseInt(idDente));
        if (dente == null) {
            System.out.println("Registro de dente com ID: " + idDente + " NAO encontrado em VisualizarHistoricoDenteAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        Collection<HistoricoDente> historicoDenteCollectionOrdenadoDescData = new ArrayList<HistoricoDente>();
        historicoDenteCollectionOrdenadoDescData = HistoricoDenteService.getHistoricoDenteOrdenadoDescData(dente);

        // Coloca o objeto 'dente' no request
        request.setAttribute("dente", dente);

        // Coloca o objeto 'historicoDenteCollectionOrdenadoDescData' no request
        request.setAttribute("historicoDenteCollectionOrdenadoDescData", historicoDenteCollectionOrdenadoDescData);

        return mapping.findForward(SUCESSO);
    }
}