package web.filaAtendimentoOrcamento;

import annotations.AtendimentoOrcamento;
import annotations.Ficha;
import annotations.Paciente;
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
public class IncluirAtendimentoOrcamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String PACIENTEINATIVO = "pacienteInativo";
    private static final String FALHAINCLUIRFICHAFILAORCAMENTO = "falhaIncluirFichaFilaOrcamento";
    private static final String FICHAJAESTANAFILAATENDIMENTOORCAMENTO = "fichaJaEstaNaFilaAtendimentoOrcamento";
    private static final String FICHAJAESTANAFILAATENDIMENTOTRATAMENTO = "fichaJaEstaNaFilaAtendimentoTratamento";
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

        // Captura o id do paciente que vem da pagina consultar paciente
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }

        // Instancia objeto Paciente com o ID capturado acima
        Paciente paciente = new Paciente();
        paciente.setId(Integer.parseInt(idPaciente));

        // Busca ficha do paciente no banco e instancia objeto
        Ficha ficha = new Ficha();
        ficha = FichaService.getFicha(paciente);
        if (ficha == null) {
            System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em IncluirAtendimentoOrcamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o paciente estah ativo no sistema
        if (ficha.getPaciente().getStatus() != 'A') {
            System.out.println("O paciente de ID: " + ficha.getPaciente().getId() + " estah inativo e tentou-se inclui-lo na fila de atendimento de orcamentos. Registro mapeado em IncluirAtendimentoOrcamentoAction");
            return mapping.findForward(PACIENTEINATIVO);
        }

        // Verifica se a ficha do paciente estah em alguma fila de atendimento de orcamento
        if (ficha.getPaciente().isFilaOrcamento()) {
            System.out.println("A ficha de ID: " + ficha.getId() + " ja estah na fila de atendimento de orcamentos ou em atendimento. Registro mapeado em IncluirAtendimentoOrcamentoAction");
            return mapping.findForward(FICHAJAESTANAFILAATENDIMENTOORCAMENTO);
        }

        // Verifica se a ficha do paciente estah em alguma fila de atendimento de tratamento
        if (ficha.getPaciente().isFilaTratamento()) {
            System.out.println("A ficha de ID: " + ficha.getId() + " ja estah na fila de atendimento de tratamentos ou em atendimento. Registro mapeado em IncluirAtendimentoOrcamentoAction");
            return mapping.findForward(FICHAJAESTANAFILAATENDIMENTOTRATAMENTO);
        }

        // Marca flag filaOrcamento em paciente como true e atualiza registro
        ficha.getPaciente().setFilaOrcamento(Boolean.TRUE);
        if (PacienteService.atualizar(ficha.getPaciente())) {
            System.out.println("Registro de Paciente atualizado com sucesso em IncluirAtendimentoOrcamentoAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Paciente em IncluirAtendimentoOrcamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Cria objeto atendimentoOrcamento associado ah ficha do paciente e a filaAtendimentoOrcamento
        AtendimentoOrcamento atendimentoOrcamento = AtendimentoOrcamentoService.getNovoAtendimentoOrcamento(ficha, FilaAtendimentoOrcamentoService.getFilaAtendimentoOrcamento());

        // Salva registro de atendimentoOrcamento no banco
        Integer id = AtendimentoOrcamentoService.salvar(atendimentoOrcamento);
        if (id != null) {
            System.out.println("Registro de AtendimentoOrcamento (ID = " + id + ") para o paciente (ID = " + idPaciente + ") incluido com sucesso na fila de atendimento de orcamentos");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao incluir registro de atendimentoOrcamento para o paciente de ID: " + idPaciente + " na fila de atendimento de orcamentos");
            return mapping.findForward(FALHAINCLUIRFICHAFILAORCAMENTO);
        }
    }
}
