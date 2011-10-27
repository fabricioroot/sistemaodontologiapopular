package web.paciente;

import annotations.Dente;
import annotations.Ficha;
import annotations.HistoricoBoca;
import annotations.HistoricoDente;
import annotations.Paciente;
import annotations.Pagamento;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;
import java.util.HashSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.DenteService;
import service.FichaService;
import service.HistoricoBocaService;
import service.HistoricoDenteService;
import service.PagamentoService;

/**
 *
 * @author Fabricio Reis
 */
public class VisualizarOdontogramaAction extends org.apache.struts.action.Action {

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

        // Captura o id do paciente que vem da pagina consultarFilaAtendimentoOrcamento
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }
        Paciente paciente = new Paciente(Integer.parseInt(idPaciente));

        Ficha ficha = FichaService.getFicha(paciente);
        if (ficha == null) {
            System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em VisualizarOdontogramaAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Coloca o objeto 'paciente' no request
        request.setAttribute("paciente", ficha.getPaciente());

        // Monta Collection com os dentes validos (que ja foram tratados alguma vez / que tem registro no banco)
        Set<Dente> dentesValidos = new HashSet<Dente>();
        dentesValidos = DenteService.getDentes(ficha.getPaciente().getBoca());

        // Identifica os dentes do paciente
        Dente dente18 = DenteService.getDente(dentesValidos, "18");
        Dente dente17 = DenteService.getDente(dentesValidos, "17");
        Dente dente16 = DenteService.getDente(dentesValidos, "16");
        Dente dente15 = DenteService.getDente(dentesValidos, "15");
        Dente dente14 = DenteService.getDente(dentesValidos, "14");
        Dente dente13 = DenteService.getDente(dentesValidos, "13");
        Dente dente12 = DenteService.getDente(dentesValidos, "12");
        Dente dente11 = DenteService.getDente(dentesValidos, "11");
        Dente dente21 = DenteService.getDente(dentesValidos, "21");
        Dente dente22 = DenteService.getDente(dentesValidos, "22");
        Dente dente23 = DenteService.getDente(dentesValidos, "23");
        Dente dente24 = DenteService.getDente(dentesValidos, "24");
        Dente dente25 = DenteService.getDente(dentesValidos, "25");
        Dente dente26 = DenteService.getDente(dentesValidos, "26");
        Dente dente27 = DenteService.getDente(dentesValidos, "27");
        Dente dente28 = DenteService.getDente(dentesValidos, "28");
        Dente dente31 = DenteService.getDente(dentesValidos, "31");
        Dente dente32 = DenteService.getDente(dentesValidos, "32");
        Dente dente33 = DenteService.getDente(dentesValidos, "33");
        Dente dente34 = DenteService.getDente(dentesValidos, "34");
        Dente dente35 = DenteService.getDente(dentesValidos, "35");
        Dente dente36 = DenteService.getDente(dentesValidos, "36");
        Dente dente37 = DenteService.getDente(dentesValidos, "37");
        Dente dente38 = DenteService.getDente(dentesValidos, "38");
        Dente dente48 = DenteService.getDente(dentesValidos, "48");
        Dente dente47 = DenteService.getDente(dentesValidos, "47");
        Dente dente46 = DenteService.getDente(dentesValidos, "46");
        Dente dente45 = DenteService.getDente(dentesValidos, "45");
        Dente dente44 = DenteService.getDente(dentesValidos, "44");
        Dente dente43 = DenteService.getDente(dentesValidos, "43");
        Dente dente42 = DenteService.getDente(dentesValidos, "42");
        Dente dente41 = DenteService.getDente(dentesValidos, "41");

        // Coloca os dentes no request
        request.setAttribute("dente18", dente18);
        request.setAttribute("dente17", dente17);
        request.setAttribute("dente16", dente16);
        request.setAttribute("dente15", dente15);
        request.setAttribute("dente14", dente14);
        request.setAttribute("dente13", dente13);
        request.setAttribute("dente12", dente12);
        request.setAttribute("dente11", dente11);
        request.setAttribute("dente21", dente21);
        request.setAttribute("dente22", dente22);
        request.setAttribute("dente23", dente23);
        request.setAttribute("dente24", dente24);
        request.setAttribute("dente25", dente25);
        request.setAttribute("dente26", dente26);
        request.setAttribute("dente27", dente27);
        request.setAttribute("dente28", dente28);
        request.setAttribute("dente31", dente31);
        request.setAttribute("dente32", dente32);
        request.setAttribute("dente33", dente33);
        request.setAttribute("dente34", dente34);
        request.setAttribute("dente35", dente35);
        request.setAttribute("dente36", dente36);
        request.setAttribute("dente37", dente37);
        request.setAttribute("dente38", dente38);
        request.setAttribute("dente48", dente48);
        request.setAttribute("dente47", dente47);
        request.setAttribute("dente46", dente46);
        request.setAttribute("dente45", dente45);
        request.setAttribute("dente44", dente44);
        request.setAttribute("dente43", dente43);
        request.setAttribute("dente42", dente42);
        request.setAttribute("dente41", dente41);

        // Busca registros de historicoDente com status orcado
        Collection<HistoricoDente> planoTratamentoDentes = new ArrayList<HistoricoDente>();
        planoTratamentoDentes = HistoricoDenteService.getHistoricoDenteOrcadoPagoTratandoDescData(dentesValidos);
        // Coloca o objeto planoTratamentoDentes no request
        request.setAttribute("planoTratamentoDentes", planoTratamentoDentes);

        // Busca registros de historicoBoca com status orcado
        Collection<HistoricoBoca> planoTratamentoBoca = new ArrayList<HistoricoBoca>();
        planoTratamentoBoca = HistoricoBocaService.getHistoricoBocaOrcadoDescData(ficha.getPaciente().getBoca());
        // Coloca o objeto planoTratamentoBoca no request
        request.setAttribute("planoTratamentoBoca", planoTratamentoBoca);

        // Calcula o valor total do tratamento (historico de dente e de boca com status orcado)
        Double totalTratamento = Double.parseDouble("0");
        if (planoTratamentoDentes != null) {
            totalTratamento += HistoricoDenteService.getTotalValorCobrado(planoTratamentoDentes);
        }
        if (planoTratamentoBoca != null) {
            totalTratamento += HistoricoBocaService.getTotalValorCobrado( new HashSet(planoTratamentoBoca));
        }
        // Coloca o objeto totalTratamento no request
        request.setAttribute("totalTratamento", totalTratamento);

        // Busca registros de pagamentos
        Collection<Pagamento> pagamentos = new ArrayList<Pagamento>();
        pagamentos = PagamentoService.getPagamentosOrdenadoDescData(ficha);
        // Coloca o objeto pagamentos no request
        request.setAttribute("pagamentos", pagamentos);

        // Calcula o valor total dos pagamentos
        Double totalPagamentos = Double.parseDouble("0");
        if (pagamentos != null) {
            totalPagamentos += PagamentoService.getValorTotal(pagamentos);
        }
        // Coloca o objeto totalPagamentos no request
        request.setAttribute("totalPagamentos", totalPagamentos);

        // Busca registros de historicoDente com status diferente de orcado
        Collection<HistoricoDente> debitosDente = new ArrayList<HistoricoDente>();
        debitosDente = HistoricoDenteService.getHistoricoDenteDiferenteDeOrcadoDescData(dentesValidos);
        // Coloca o objeto debitosDente no request
        request.setAttribute("debitosDente", debitosDente);

        // Busca registros de historicoBoca com status diferente de orcado
        Collection<HistoricoBoca> debitosBoca = new ArrayList<HistoricoBoca>();
        debitosBoca = HistoricoBocaService.getHistoricoBocaDiferenteDeOrcadoDescData(ficha.getPaciente().getBoca());
        // Coloca o objeto debitosBoca no request
        request.setAttribute("debitosBoca", debitosBoca);

        // Calcula o valor total dos debitos (historico de dente e de boca com status diferente de orcado)
        Double totalDebitos = Double.parseDouble("0");
        if (debitosDente != null) {
            totalDebitos += HistoricoDenteService.getTotalValorCobrado(debitosDente);
        }
        if (debitosBoca != null) {
            totalDebitos += HistoricoBocaService.getTotalValorCobrado(new HashSet(debitosBoca));
        }
        // Coloca o objeto totalDebitos no request
        request.setAttribute("totalDebitos", totalDebitos);

        // Coloca o saldo da ficha do paciente no request
        request.setAttribute("saldoFicha", ficha.getSaldo());

        return mapping.findForward(SUCESSO);
    }
}