package web.filaAtendimentoTratamento;

import annotations.AtendimentoTratamento;
import annotations.Dente;
import annotations.Ficha;
import annotations.HistoricoBoca;
import annotations.HistoricoDente;
import annotations.Paciente;
import annotations.Dentista;
import annotations.Funcionario;
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
import service.AtendimentoTratamentoService;
import service.DenteService;
import service.FichaService;
import service.HistoricoBocaService;
import service.HistoricoDenteService;
import service.PagamentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class ContinuarAtendimentoTratamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHACONTINUARTRATAMENTO = "falhaContinuarTratamento";
    private static final String FALHAIDENTIFICARUSUARIOLOGADO = "falhaIdentificarUsuarioLogado";
    private static final String FUNCIONARIONAOEHDENTISTA = "funcionarioNaoEhDentista";
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

        // Captura o id do paciente que vem da pagina consultarFilaAtendimentoTratamentoEmAtendimento
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }
        Paciente paciente = new Paciente(Integer.parseInt(idPaciente));
        // Coloca 'idPaciente' na sessao...
        // Ele serah usado em sucessoIncluirProcedimento.jsp, atendimentoTratamento/incluirProcedimento.jsp, atendimentoTratamento/incluirProcedimentoBoca.jsp
        request.getSession(false).setAttribute("idPaciente", idPaciente);

        // Busca registro de ficha no banco a partir de objeto 'paciente'
        Ficha ficha = new Ficha();
        ficha = FichaService.getFicha(paciente);
        if (ficha == null) {
            System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em ContinuarAtendimentoTratamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        if (request.getSession(false).getAttribute("atendimentoTratamento") == null) {
            // Captura o id do atendimento que vem da pagina consultarFilaAtendimentoTratamentoEmAtendimento
            String idAtendimentoTratamento = "";
            if (request.getParameter("idAtendimento") != null) {
                idAtendimentoTratamento = request.getParameter("idAtendimento");
            }

            // Busca registro de atendimentoTratamento
            if (!idAtendimentoTratamento.isEmpty()) {
                atendimentoTratamento = AtendimentoTratamentoService.getAtendimentoTratamento(Integer.parseInt(idAtendimentoTratamento));
            }
            if (atendimentoTratamento.getId() == null) {
                System.out.println("Registro AtendimentoTratamento NAO encontrado em ContinuarAtendimentoTratamentoAction");
                return mapping.findForward(FALHACONSULTAR);
            }

            // Remarca o dentista...
            try {
                Dentista dentista = (Dentista) request.getSession(false).getAttribute("funcionarioLogado");
                atendimentoTratamento.setDentista(dentista);
            } catch (Exception e) {
                Funcionario funcionario = (Funcionario) request.getSession(false).getAttribute("funcionarioLogado");
                if (!funcionario.getCargo().equals("Dentista-Orcamento") || !funcionario.getCargo().equals("Dentista-Tratamento") || !funcionario.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                    System.out.println("Falha ao tentar identificar FuncionarioLogado, pois ele NAO eh Dentista. Falha mapeada em ContinuarAtendimentoTratamentoAction. Erro: " + e.getMessage() );
                    return mapping.findForward(FUNCIONARIONAOEHDENTISTA);
                }
                else {
                    System.out.println("Falha ao tentar identificar funcionarioLogado em ContinuarAtendimentoTratamentoAction. Erro: " + e.getMessage() );
                    return mapping.findForward(FALHAIDENTIFICARUSUARIOLOGADO);
                }
            }

            // Coloca o registro de atendimentoTratamento na sessao...
            // Ele serah usado em atendimentoTratamento.IncluirProcedimentoBocaAction e atendimentoTratamento.IncluirProcedimentoAction
            try {
                request.getSession(false).setAttribute("atendimentoTratamento", atendimentoTratamento);
            } catch (Exception e) {
                System.out.println("Falha ao colocar registro de atendimentoTratamento na sessao em ContinuarAtendimentoTratamentoAction! Erro: " + e.getMessage());
                return mapping.findForward(FALHACONTINUARTRATAMENTO);
            }
        }
        else {
            atendimentoTratamento = (AtendimentoTratamento) request.getSession(false).getAttribute("atendimentoTratamento");

            // Remarca o dentista...
            try {
                Dentista dentista = (Dentista) request.getSession(false).getAttribute("funcionarioLogado");
                atendimentoTratamento.setDentista(dentista);
            } catch (Exception e) {
                Funcionario funcionario = (Funcionario) request.getSession(false).getAttribute("funcionarioLogado");
                if (!funcionario.getCargo().equals("Dentista-Orcamento") || !funcionario.getCargo().equals("Dentista-Tratamento") || !funcionario.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                    System.out.println("Falha ao tentar identificar FuncionarioLogado, pois ele NAO eh Dentista. Falha mapeada em ContinuarAtendimentoTratamentoAction. Erro: " + e.getMessage() );
                    return mapping.findForward(FUNCIONARIONAOEHDENTISTA);
                }
                else {
                    System.out.println("Falha ao tentar identificar funcionarioLogado em ContinuarAtendimentoTratamentoAction. Erro: " + e.getMessage() );
                    return mapping.findForward(FALHAIDENTIFICARUSUARIOLOGADO);
                }
            }

            // Atualizar o registro de atendimentoTratamento da sessao...
            // Ele serah usado em atendimentoTratamento.IncluirProcedimentoBocaAction e atendimentoTratamento.IncluirProcedimentoAction
            try {
                request.getSession(false).setAttribute("atendimentoTratamento", atendimentoTratamento);
            } catch (Exception e) {
                System.out.println("Falha ao atualizar registro de atendimentoTratamento da sessao em ContinuarAtendimentoTratamentoAction! Erro: " + e.getMessage());
                return mapping.findForward(FALHACONTINUARTRATAMENTO);
            }
        }

        // Coloca objeto 'paciente' no request
        request.setAttribute("paciente", ficha.getPaciente());

        // Monta Set com os dentes validos (que ja foram tratados alguma vez / que tem registro no banco)
        Set<Dente> dentesValidos = new HashSet<Dente>();
        dentesValidos = DenteService.getDentes(ficha.getPaciente().getBoca());

        // Identifica e instancia objeto Dente para cada dente encontrado
        Dente dente18 = DenteService.getDente(dentesValidos, "18") == null ? new Dente("Terceiro Molar Superior Direito", "18", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "18");
        Dente dente17 = DenteService.getDente(dentesValidos, "17") == null ? new Dente("Segundo Molar Superior Direito", "17", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "17");
        Dente dente16 = DenteService.getDente(dentesValidos, "16") == null ? new Dente("Primeiro Molar Superior Direito", "16", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "16");
        Dente dente15 = DenteService.getDente(dentesValidos, "15") == null ? new Dente("Segundo Pre-Molar Superior Direito", "15", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "15");
        Dente dente14 = DenteService.getDente(dentesValidos, "14") == null ? new Dente("Primeiro Pre-Molar Superior Direito", "14", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "14");
        Dente dente13 = DenteService.getDente(dentesValidos, "13") == null ? new Dente("Canino Superior Direito", "13", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "13");
        Dente dente12 = DenteService.getDente(dentesValidos, "12") == null ? new Dente("Incisivo Lateral Superior Direito", "12", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "12");
        Dente dente11 = DenteService.getDente(dentesValidos, "11") == null ? new Dente("Incisivo Central Superior Direito", "11", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "11");
        Dente dente21 = DenteService.getDente(dentesValidos, "21") == null ? new Dente("Incisivo Central Superior Esquerdo", "21", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "21");
        Dente dente22 = DenteService.getDente(dentesValidos, "22") == null ? new Dente("Incisivo Lateral Superior Esquerdo", "22", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "22");
        Dente dente23 = DenteService.getDente(dentesValidos, "23") == null ? new Dente("Canino Superior Esquerdo", "23", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "23");
        Dente dente24 = DenteService.getDente(dentesValidos, "24") == null ? new Dente("Primeiro Pre-Molar Superior Esquerdo", "24", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "24");
        Dente dente25 = DenteService.getDente(dentesValidos, "25") == null ? new Dente("Segundo Pre-Molar Superior Esquerdo", "25", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "25");
        Dente dente26 = DenteService.getDente(dentesValidos, "26") == null ? new Dente("Primeiro Molar Superior Esquerdo", "26", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "26");
        Dente dente27 = DenteService.getDente(dentesValidos, "27") == null ? new Dente("Segundo Molar Superior Esquerdo", "27", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "27");
        Dente dente28 = DenteService.getDente(dentesValidos, "28") == null ? new Dente("Terceiro Molar Superior Esquerdo", "28", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "28");
        Dente dente31 = DenteService.getDente(dentesValidos, "31") == null ? new Dente("Incisivo Central Inferior Esquerdo", "31", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "31");
        Dente dente32 = DenteService.getDente(dentesValidos, "32") == null ? new Dente("Incisivo Lateral Inferior Esquerdo", "32", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "32");
        Dente dente33 = DenteService.getDente(dentesValidos, "33") == null ? new Dente("Canino Inferior Esquerdo", "33", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "33");
        Dente dente34 = DenteService.getDente(dentesValidos, "34") == null ? new Dente("Primeiro Pre-Molar Inferior Esquerdo", "34", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "34");
        Dente dente35 = DenteService.getDente(dentesValidos, "35") == null ? new Dente("Segundo Pre-Molar Inferior Esquerdo", "35", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "35");
        Dente dente36 = DenteService.getDente(dentesValidos, "36") == null ? new Dente("Primeiro Molar Inferior Esquerdo", "36", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "36");
        Dente dente37 = DenteService.getDente(dentesValidos, "37") == null ? new Dente("Segundo Molar Inferior Esquerdo", "37", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "37");
        Dente dente38 = DenteService.getDente(dentesValidos, "38") == null ? new Dente("Terceiro Molar Inferior Esquerdo", "38", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "38");
        Dente dente48 = DenteService.getDente(dentesValidos, "48") == null ? new Dente("Terceiro Molar Inferior Direito", "48", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "48");
        Dente dente47 = DenteService.getDente(dentesValidos, "47") == null ? new Dente("Segundo Molar Inferior Direito", "47", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "47");
        Dente dente46 = DenteService.getDente(dentesValidos, "46") == null ? new Dente("Primeiro Molar Inferior Direito", "46", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "46");
        Dente dente45 = DenteService.getDente(dentesValidos, "45") == null ? new Dente("Segundo Pre-Molar Inferior Direito", "45", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "45");
        Dente dente44 = DenteService.getDente(dentesValidos, "44") == null ? new Dente("Primeiro Pre-Molar Inferior Direito", "44", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "44");
        Dente dente43 = DenteService.getDente(dentesValidos, "43") == null ? new Dente("Canino Inferior Direito", "43", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "43");
        Dente dente42 = DenteService.getDente(dentesValidos, "42") == null ? new Dente("Incisivo Lateral Inferior Direito", "42", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "42");
        Dente dente41 = DenteService.getDente(dentesValidos, "41") == null ? new Dente("Incisivo Central Inferior Direito", "41", ficha.getPaciente().getBoca()) : DenteService.getDente(dentesValidos, "41");

        // Coloca os dentes no request
        request.getSession(false).setAttribute("dente18", dente18);
        request.getSession(false).setAttribute("dente17", dente17);
        request.getSession(false).setAttribute("dente16", dente16);
        request.getSession(false).setAttribute("dente15", dente15);
        request.getSession(false).setAttribute("dente14", dente14);
        request.getSession(false).setAttribute("dente13", dente13);
        request.getSession(false).setAttribute("dente12", dente12);
        request.getSession(false).setAttribute("dente11", dente11);
        request.getSession(false).setAttribute("dente21", dente21);
        request.getSession(false).setAttribute("dente22", dente22);
        request.getSession(false).setAttribute("dente23", dente23);
        request.getSession(false).setAttribute("dente24", dente24);
        request.getSession(false).setAttribute("dente25", dente25);
        request.getSession(false).setAttribute("dente26", dente26);
        request.getSession(false).setAttribute("dente27", dente27);
        request.getSession(false).setAttribute("dente28", dente28);
        request.getSession(false).setAttribute("dente31", dente31);
        request.getSession(false).setAttribute("dente32", dente32);
        request.getSession(false).setAttribute("dente33", dente33);
        request.getSession(false).setAttribute("dente34", dente34);
        request.getSession(false).setAttribute("dente35", dente35);
        request.getSession(false).setAttribute("dente36", dente36);
        request.getSession(false).setAttribute("dente37", dente37);
        request.getSession(false).setAttribute("dente38", dente38);
        request.getSession(false).setAttribute("dente48", dente48);
        request.getSession(false).setAttribute("dente47", dente47);
        request.getSession(false).setAttribute("dente46", dente46);
        request.getSession(false).setAttribute("dente45", dente45);
        request.getSession(false).setAttribute("dente44", dente44);
        request.getSession(false).setAttribute("dente43", dente43);
        request.getSession(false).setAttribute("dente42", dente42);
        request.getSession(false).setAttribute("dente41", dente41);

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