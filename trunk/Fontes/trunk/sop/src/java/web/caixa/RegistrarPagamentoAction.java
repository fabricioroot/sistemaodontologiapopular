package web.caixa;

import annotations.Dente;
import annotations.Ficha;
import annotations.HistoricoBoca;
import annotations.HistoricoDente;
import annotations.Paciente;
import annotations.Pagamento;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
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
public class RegistrarPagamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAIDENTIFICARFICHA = "falhaIdentificarFicha";
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

        Ficha ficha = new Ficha();

        // Captura o id do paciente que vem da pagina consultarPacienteParaPagamentos.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
            Paciente paciente = new Paciente(Integer.parseInt(idPaciente));
            ficha = FichaService.getFicha(paciente);
            if (ficha == null) {
                System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em RegistrarPagamentoAction");
                return mapping.findForward(FALHACONSULTAR);
            }
            // Coloca o objeto 'ficha' na sessao para uso posterior (forward no struts apos insercao de cheques)
            request.getSession(false).setAttribute("fichaPagamento", ficha);
        }
        else {
            if (request.getSession(false).getAttribute("fichaPagamento") != null) {
                ficha = (Ficha)request.getSession(false).getAttribute("fichaPagamento");
            }
            else {
                System.out.println("Falha ao buscar registro de ficha na sessao em RegistrarPagamentoAction.");
                return mapping.findForward(FALHAIDENTIFICARFICHA);
            }
        }

        // Coloca o objeto 'paciente' no request
        request.setAttribute("paciente", ficha.getPaciente());

        // Monta Set com os dentes validos (que ja foram tratados alguma vez / que tem registro no banco)
        Set<Dente> dentesValidos = new HashSet<Dente>();
        dentesValidos = DenteService.getDentes(ficha.getPaciente().getBoca());

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
            totalTratamento += HistoricoBocaService.getTotalValorCobrado(new HashSet(planoTratamentoBoca));
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