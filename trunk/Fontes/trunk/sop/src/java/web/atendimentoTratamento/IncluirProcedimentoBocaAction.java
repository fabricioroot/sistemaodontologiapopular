package web.atendimentoTratamento;

import annotations.AtendimentoTratamento;
import annotations.Boca;
import annotations.HistoricoBoca;
import annotations.Procedimento;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoOrcamentoService;
import service.HistoricoBocaService;
import service.StatusProcedimentoService;
import web.atendimentoOrcamento.IncluirProcedimentoBocaActionForm;

/**
 *
 * @author Fabricio Reis
 */
public class IncluirProcedimentoBocaAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHASALVAR = "falhaAtualizar";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
    private static final String VALORCOBRADOINVALIDO = "valorCobradoInvalido";
    private static final String SESSAOINVALIDA = "sessaoInvalida";
    private static final String FALHAIDENTIFICARATENDIMENTO = "falhaIdentificarAtendimento";

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

        IncluirProcedimentoBocaActionForm formIncluirProcedimentoBoca = (IncluirProcedimentoBocaActionForm) form;

        // Verifica se os campos obrigatorios foram preenchidos
        if ((formIncluirProcedimentoBoca.getProcedimentoId().toString().trim().isEmpty()) || (formIncluirProcedimentoBoca.getValorCobrado().toString().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        // Verifica se o valor cobrado eh valido
        if (formIncluirProcedimentoBoca.getValorCobrado() < formIncluirProcedimentoBoca.getValorMinimo()) {
            return mapping.findForward(VALORCOBRADOINVALIDO);
        }

        // Monta objeto HistoricoBoca
        HistoricoBoca historicoBoca = new HistoricoBoca();
        historicoBoca.setValorCobrado(formIncluirProcedimentoBoca.getValorCobrado());
        historicoBoca.setDataHora(new Date());
        historicoBoca.setObservacao(formIncluirProcedimentoBoca.getObservacao().trim());
        // Marca statusProcedimento como orcado
        historicoBoca.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoOrcado());
        historicoBoca.setBoca(new Boca(formIncluirProcedimentoBoca.getBocaId()));

        // Captura da sessao o registro atendimentoTratamento
        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        try {
            atendimentoTratamento = (AtendimentoTratamento) request.getSession(false).getAttribute("atendimentoTratamento");
        } catch(Exception e) {
            System.out.println("Falha ao capturar registro de atendimentoTratamento da sessao em atendimentoTratamento.IncluirProcedimentoBocaAction. Erro: " + e.getMessage());
            return mapping.findForward(FALHAIDENTIFICARATENDIMENTO);
        }
        historicoBoca.setDentista(atendimentoTratamento.getDentista());
        historicoBoca.setProcedimento(new Procedimento(formIncluirProcedimentoBoca.getProcedimentoId()));
        historicoBoca.setAtendimentoTratamento(atendimentoTratamento);
        historicoBoca.setAtendimentoOrcamento(AtendimentoOrcamentoService.getAtendimentoOrcamentoSistema());

        Integer id = HistoricoBocaService.salvar(historicoBoca);
        if(id != null) {
            System.out.println("Registro de HistoricoBoca (ID = " + id + ") salvo com sucesso em atendimentoTratamento.IncluirProcedimentoBocaAction");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao salvar registro de HistoricoBoca em atendimentoTratamento.IncluirProcedimentoBocaAction");
            return mapping.findForward(FALHASALVAR);
        }
    }
}