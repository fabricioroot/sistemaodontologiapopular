package web.filaAtendimentoOrcamento;

import annotations.AtendimentoOrcamento;
import annotations.Ficha;
import annotations.Paciente;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoOrcamentoService;
import service.FichaService;
import service.FilaAtendimentoOrcamentoService;
import service.PacienteService;

/**
 *
 * @author Fabricio P. Reis
 */
public class RemoverAtendimentoOrcamentoAction extends org.apache.struts.action.Action {

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

        // Captura o id do paciente que vem da pagina consultarFilaAtendimentoOrcamento
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }
        Paciente paciente = new Paciente(Integer.parseInt(idPaciente));

        // Busca registro de ficha no banco a partir de 'paciente'
        Ficha ficha = new Ficha();
        ficha = FichaService.getFicha(paciente);
        if (ficha == null) {
            System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em RemoverAtendimentoOrcamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Marca flag filaOrcamento em paciente como false e atualiza registro
        ficha.getPaciente().setFilaOrcamento(Boolean.FALSE);
        if (PacienteService.atualizar(ficha.getPaciente())) {
            System.out.println("Registro de Paciente atualizado com sucesso em RemoverAtendimentoOrcamentoAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Paciente em RemoverAtendimentoOrcamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Busca registro 'AtendimentoOrcamento' associada a 'ficha' que nao foi iniciado
        AtendimentoOrcamento atendimentoOrcamento = new AtendimentoOrcamento();
        atendimentoOrcamento = AtendimentoOrcamentoService.getAtendimentoOrcamentoNaoIniciado(ficha);
        if (atendimentoOrcamento == null) {
            System.out.println("Registro AtendimentoOrcamento NAO encontrado em RemoverAtendimentoOrcamentoAction");
            return mapping.findForward(ATENDIMENTOINICIADOOUREMOVIDODAFILA);
        }

        // Finaliza o atendimento orcamento removendo seu registro da fila de atendimento de orcamentos...
        atendimentoOrcamento.setDataInicio(new Date());
        atendimentoOrcamento.setDataFim(new Date());
        atendimentoOrcamento.setFilaAtendimentoOrcamento(FilaAtendimentoOrcamentoService.getFilaAtendimentoOrcamentoFinalizado());
        if (AtendimentoOrcamentoService.atualizar(atendimentoOrcamento)) {
            System.out.println("Registro de AtendimentoOrcamento atualizado com sucesso em RemoverAtendimentoOrcamentoAction");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de AtendimentoOrcamento em RemoverAtendimentoOrcamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}