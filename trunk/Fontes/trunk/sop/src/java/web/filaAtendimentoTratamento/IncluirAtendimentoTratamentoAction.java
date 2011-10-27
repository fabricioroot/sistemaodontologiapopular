package web.filaAtendimentoTratamento;

import annotations.AtendimentoTratamento;
import annotations.Ficha;
import annotations.Paciente;
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
public class IncluirAtendimentoTratamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String PACIENTEINATIVO = "pacienteInativo";
    private static final String FALHAINCLUIRFICHAFILATRATAMENTO = "falhaIncluirFichaFilaTratamento";
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

        // Captura o id do paciente que vem da pagina consultarPaciente.jsp
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
            System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em IncluirAtendimentoTratamentoAction");
            return mapping.findForward(FALHACONSULTAR);
        }

        // Verifica se o paciente estah ativo no sistema
        if (ficha.getPaciente().getStatus() != 'A') {
            System.out.println("O paciente de ID: " + ficha.getPaciente().getId() + " estah nao estah ativo. Assim, ele nao pode ser incluido na fila de atendimento de tratamento. Registro mapeado em IncluirAtendimentoTratamentoAction");
            return mapping.findForward(PACIENTEINATIVO);
        }

        // Verifica se a ficha do paciente estah em alguma fila de atendimento de tratamento
        if (ficha.getPaciente().isFilaTratamento()) {
            System.out.println("A ficha de ID: " + ficha.getId() + " ja estah na fila de atendimento de tratamentos ou em atendimento. Registro mapeado em IncluirAtendimentoTratamentoAction");
            return mapping.findForward(FICHAJAESTANAFILAATENDIMENTOTRATAMENTO);
        }

        // Verifica se a ficha do paciente estah em alguma fila de atendimento de orcamento
        if (ficha.getPaciente().isFilaOrcamento()) {
            System.out.println("A ficha de ID: " + ficha.getId() + " ja estah na fila de atendimento de orcamentos ou em atendimento. Registro mapeado em IncluirAtendimentoTratamentoAction");
            return mapping.findForward(FICHAJAESTANAFILAATENDIMENTOORCAMENTO);
        }

        // Marca flag filaTratamento em paciente como true e atualiza registro
        ficha.getPaciente().setFilaTratamento(Boolean.TRUE);
        if (PacienteService.atualizar(ficha.getPaciente())) {
            System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") atualizado com sucesso em IncluirAtendimentoTratamentoAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") em IncluirAtendimentoTratamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Cria objeto atendimentoTratamento associado ah ficha do paciente e a filaAtendimentoTratamento
        AtendimentoTratamento atendimentoTratamento = AtendimentoTratamentoService.getNovoAtendimentoTratamento(ficha, FilaAtendimentoTratamentoService.getFilaAtendimentoTratamento());

        // Salva registro de atendimentoTratamento no banco
        Integer id = AtendimentoTratamentoService.salvar(atendimentoTratamento);
        if (id != null) {
            System.out.println("Registro de AtendimentoTratamento (ID = " + id + ") para o paciente (ID = " + idPaciente + ") incluido com sucesso na fila de atendimento de tratamentos");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao incluir registro de atendimentoTratamento para o paciente de ID: " + idPaciente + " na fila de atendimento de tratamentos");
            return mapping.findForward(FALHAINCLUIRFICHAFILATRATAMENTO);
        }
        
    }
}