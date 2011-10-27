package web.atendimentoTratamento;

import annotations.AtendimentoTratamento;
import annotations.Dente;
import annotations.HistoricoDente;
import annotations.Procedimento;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoOrcamentoService;
import service.DenteService;
import service.StatusProcedimentoService;
import web.atendimentoOrcamento.IncluirProcedimentoActionForm;

/**
 *
 * @author Fabricio Reis
 */
public class IncluirProcedimentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHASALVAR = "falhaSalvar";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
    private static final String VALORCOBRADOINVALIDO = "valorCobradoInvalido";
    private static final String SESSAOINVALIDA = "sessaoInvalida";
    private static final String FALHAIDENTIFICARATENDIMENTO = "falhaIdentificarAtendimento";
    private static final String FALHAIDENTIFICARDENTE = "falhaIdentificarDente";

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

        IncluirProcedimentoActionForm formIncluirProcedimento = (IncluirProcedimentoActionForm) form;

        // Verifica se os campos obrigatorios foram preenchidos
        if ((formIncluirProcedimento.getProcedimentoId().toString().trim().isEmpty()) || (formIncluirProcedimento.getValorCobrado().toString().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        // Verifica se o valor cobrado eh valido
        if (formIncluirProcedimento.getValorCobrado() < formIncluirProcedimento.getValorMinimo()) {
            return mapping.findForward(VALORCOBRADOINVALIDO);
        }
        else {
            // Marreta para re-verificar se o valor cobrado eh valido
            if (!formIncluirProcedimento.getTipoProcedimento().equals("DI")) {
                int count = 0;
                if (formIncluirProcedimento.getFaceSuperior() != null) count++;
                if (formIncluirProcedimento.getFaceEsquerda() != null) count++;
                if (formIncluirProcedimento.getFaceMeio() != null) count++;
                if (formIncluirProcedimento.getFaceDireita() != null) count++;
                if (formIncluirProcedimento.getFaceInferior() != null) count++;
                if (formIncluirProcedimento.getRaiz() != null) count++;

                if (formIncluirProcedimento.getValorCobrado() < (count * formIncluirProcedimento.getValorMinimoProcedimento())) {
                    return mapping.findForward(VALORCOBRADOINVALIDO);
                }
            }
        }

        // Monta objeto HistoricoDente...
        HistoricoDente historicoDente = new HistoricoDente();
        historicoDente.setValorCobrado(formIncluirProcedimento.getValorCobrado());
        historicoDente.setDataHora(new Date());
        historicoDente.setObservacao(formIncluirProcedimento.getObservacao().trim());

        // Marreta!
        // Marca as partes do dente alteradas (orcadas)...
        String dentePosicao = formIncluirProcedimento.getDentePosicao();
        if (dentePosicao.startsWith("1")) {
            historicoDente.setFaceBucal(formIncluirProcedimento.getFaceSuperior() == null ? Boolean.FALSE : Boolean.TRUE);
            historicoDente.setFaceDistal(formIncluirProcedimento.getFaceEsquerda() == null ? Boolean.FALSE : Boolean.TRUE);
            historicoDente.setFaceIncisal(formIncluirProcedimento.getFaceMeio() == null ? Boolean.FALSE : Boolean.TRUE);
            historicoDente.setFaceMesial(formIncluirProcedimento.getFaceDireita() == null ? Boolean.FALSE : Boolean.TRUE);
            historicoDente.setFaceLingual(formIncluirProcedimento.getFaceInferior() == null ? Boolean.FALSE : Boolean.TRUE);
        }
        else
            if (dentePosicao.startsWith("2")) {
                historicoDente.setFaceBucal(formIncluirProcedimento.getFaceSuperior() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceDistal(formIncluirProcedimento.getFaceDireita() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceIncisal(formIncluirProcedimento.getFaceMeio() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceMesial(formIncluirProcedimento.getFaceEsquerda() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceLingual(formIncluirProcedimento.getFaceInferior() == null ? Boolean.FALSE : Boolean.TRUE);
        }
        else
            if (dentePosicao.startsWith("3")) {
                historicoDente.setFaceBucal(formIncluirProcedimento.getFaceInferior() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceDistal(formIncluirProcedimento.getFaceDireita() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceIncisal(formIncluirProcedimento.getFaceMeio() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceMesial(formIncluirProcedimento.getFaceEsquerda() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceLingual(formIncluirProcedimento.getFaceSuperior() == null ? Boolean.FALSE : Boolean.TRUE);
        }
        else
            if (dentePosicao.startsWith("4")) {
                historicoDente.setFaceBucal(formIncluirProcedimento.getFaceInferior() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceDistal(formIncluirProcedimento.getFaceEsquerda() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceIncisal(formIncluirProcedimento.getFaceMeio() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceMesial(formIncluirProcedimento.getFaceDireita() == null ? Boolean.FALSE : Boolean.TRUE);
                historicoDente.setFaceLingual(formIncluirProcedimento.getFaceSuperior() == null ? Boolean.FALSE : Boolean.TRUE);
        }
        historicoDente.setRaiz(formIncluirProcedimento.getRaiz() == null ? Boolean.FALSE : Boolean.TRUE);

        // Marca statusProcedimento como orcado...
        historicoDente.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoOrcado());

        // Captura da sessao o registro atendimentoTratamento
        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        try {
            atendimentoTratamento = (AtendimentoTratamento) request.getSession(false).getAttribute("atendimentoTratamento");
        } catch(Exception e) {
            System.out.println("Falha ao capturar registro de atendimentoTratamento da sessao em IncluirProcedimentoAction. Erro: " + e.getMessage());
            return mapping.findForward(FALHAIDENTIFICARATENDIMENTO);
        }
        historicoDente.setDentista(atendimentoTratamento.getDentista());
        historicoDente.setProcedimento(new Procedimento(formIncluirProcedimento.getProcedimentoId()));
        historicoDente.setAtendimentoTratamento(atendimentoTratamento);
        historicoDente.setAtendimentoOrcamento(AtendimentoOrcamentoService.getAtendimentoOrcamentoSistema());

        Dente dente = new Dente();
        try {
            // Marreta para nao replicar registros de historico!
            Dente denteAux = (Dente) request.getSession(false).getAttribute("dente"+formIncluirProcedimento.getDentePosicao());
            if (denteAux.getId() != null) {
                dente = DenteService.getHistoricoDente(denteAux);
            }
            else {
                dente = denteAux;
            }
        } catch(Exception e) {
            System.out.println("Falha ao capturar registro de dente da sessao em atendimentoTratamento.IncluirProcedimentoAction. Erro: " + e.getMessage());
            return mapping.findForward(FALHAIDENTIFICARDENTE);
        }

        // Inclui registro de historicoDente no Set do objeto dente
        dente.getHistoricoDenteSet().add(historicoDente);

        // Atualiza os status das faces
        dente = DenteService.atualizarFaces(dente, false);

        // Marca o dente do historicoDente criado
        historicoDente.setDente(dente);

        if(DenteService.salvarOuAtualizar(dente)) {
            System.out.println("Registro de Dente salvo/atualizado com sucesso em atendimentoTratamento.IncluirProcedimentoAction");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao salvar/atualizar registro de Dente em atendimentoTratamento.IncluirProcedimentoAction");
            return mapping.findForward(FALHASALVAR);
        }
    }
}