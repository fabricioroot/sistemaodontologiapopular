package web.filaAtendimentoTratamento;

import annotations.AtendimentoTratamento;
import annotations.Ficha;
import annotations.Paciente;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoTratamentoService;
import service.FichaService;
import service.FilaAtendimentoTratamentoService;
import service.PacienteService;

/**
 *
 * @author Fabricio P. Reis
 */
public class RemoverAtendimentoTratamentoAction extends org.apache.struts.action.Action {

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

        // Captura o id do paciente que vem da pagina consultarFilaAtendimentoTratamento
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }
        Paciente paciente = new Paciente(Integer.parseInt(idPaciente));

        // Busca registro de ficha no banco a partir de 'paciente'
        Ficha ficha = new Ficha();
        ficha = FichaService.getFicha(paciente);
        if (ficha == null) {
            System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em RemoverAtendimentoTratamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Marca flag filaTratamento em paciente como false e atualiza registro
        ficha.getPaciente().setFilaTratamento(Boolean.FALSE);
        if (PacienteService.atualizar(ficha.getPaciente())) {
            System.out.println("Registro de Paciente atualizado com sucesso em RemoverAtendimentoTratamentoAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Paciente em RemoverAtendimentoTratamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Busca registro 'AtendimentoTratamento' associada a 'ficha' que nao foi iniciado
        AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
        atendimentoTratamento = AtendimentoTratamentoService.getAtendimentoTratamentoNaoIniciado(ficha);
        if (atendimentoTratamento == null) {
            System.out.println("Registro AtendimentoTratamento NAO encontrado em RemoverAtendimentoTratamentoAction");
            return mapping.findForward(ATENDIMENTOINICIADOOUREMOVIDODAFILA);
        }

        // Finaliza o atendimento tratamento removendo seu registro da fila de atendimento de tratamentos...
        atendimentoTratamento.setDataInicio(new Date());
        atendimentoTratamento.setDataFim(new Date());
        atendimentoTratamento.setFilaAtendimentoTratamento(FilaAtendimentoTratamentoService.getFilaAtendimentoTratamentoFinalizado());
        if (AtendimentoTratamentoService.atualizar(atendimentoTratamento)) {
            System.out.println("Registro de AtendimentoTratamento atualizado com sucesso em RemoverAtendimentoTratamentoAction");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de AtendimentoTratamento em RemoverAtendimentoTratamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}