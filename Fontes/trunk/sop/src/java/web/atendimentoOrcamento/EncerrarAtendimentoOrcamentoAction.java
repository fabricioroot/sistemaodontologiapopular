package web.atendimentoOrcamento;

import annotations.AtendimentoOrcamento;
import annotations.Paciente;
import annotations.Dentista;
import annotations.Funcionario;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.AtendimentoOrcamentoService;
import service.FilaAtendimentoOrcamentoService;
import service.PacienteService;

/**
 *
 * @author Fabricio P. Reis
 */
public class EncerrarAtendimentoOrcamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAIDENTIFICARATENDIMENTO = "falhaIdentificarAtendimento";
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

        // Captura na sessao o registro atendimentoOrcamento
        AtendimentoOrcamento atendimentoOrcamento = new AtendimentoOrcamento();
        try {
            atendimentoOrcamento = (AtendimentoOrcamento) request.getSession(false).getAttribute("atendimentoOrcamento");
        } catch(Exception e) {
            System.out.println("Falha ao capturar registro de atendimentoOrcamento da sessao em EncerrarAtendimentoOrcamentoAction. Erro: " + e.getMessage());
            return mapping.findForward(FALHAIDENTIFICARATENDIMENTO);
        }

        // Captura o id do paciente que vem da pagina atenderAtendimentoOrcamento.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
        }
        Paciente paciente = PacienteService.getPaciente(Integer.parseInt(idPaciente));

        // Marca flag filaOrcamento do paciente como false
        paciente.setFilaOrcamento(Boolean.FALSE);
        if (PacienteService.atualizar(paciente)) {
            System.out.println("Registro de Paciente atualizado com sucesso em EncerrarAtendimentoOrcamentoAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Paciente em EncerrarAtendimentoOrcamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Remarca o dentista...
        try {
            Dentista dentista = (Dentista) request.getSession(false).getAttribute("funcionarioLogado");
            atendimentoOrcamento.setDentista(dentista);
        } catch (Exception e) {
            Funcionario funcionario = (Funcionario) request.getSession(false).getAttribute("funcionarioLogado");
            if (!funcionario.getCargo().equals("Dentista-Orcamento") || !funcionario.getCargo().equals("Dentista-Tratamento") || !funcionario.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                System.out.println("Falha ao tentar identificar FuncionarioLogado, pois ele NAO eh Dentista. Falha mapeada em EncerrarAtendimentoOrcamentoAction. Erro: " + e.getMessage() );
                return mapping.findForward(FUNCIONARIONAOEHDENTISTA);
            }
            else {
                System.out.println("Falha ao tentar identificar funcionarioLogado em EncerrarAtendimentoOrcamentoAction. Erro: " + e.getMessage() );
                return mapping.findForward(FALHAIDENTIFICARUSUARIOLOGADO);
            }
        }

        // Marca dataFim
        atendimentoOrcamento.setDataFim(new Date());

        // Coloca na "fila de orcamentos finalizados"
        atendimentoOrcamento.setFilaAtendimentoOrcamento(FilaAtendimentoOrcamentoService.getFilaAtendimentoOrcamentoFinalizado());

        // Atualiza registro de atendimentoOrcamento no banco
        if (!AtendimentoOrcamentoService.atualizar(atendimentoOrcamento)) {
            System.out.println("Falha ao atualizar registro de atendimentoOrcamento de ID: " + atendimentoOrcamento.getId() + " para encerrar o atendimento.");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Remove objetos relacionados ao atendimento da sessao
        // -- atendimentoOrcamento, colocado na sessao por AtenderAtendimentoOrcamentoAction ou ContinuarAtendimentoOrcamentoAction
        request.getSession(false).removeAttribute("atendimentoOrcamento");
        // -- Dentes, colocados na sessao por AtenderAtendimentoOrcamentoAction ou ContinuarAtendimentoOrcamentoAction
        request.getSession(false).removeAttribute("dente18");
        request.getSession(false).removeAttribute("dente17");
        request.getSession(false).removeAttribute("dente16");
        request.getSession(false).removeAttribute("dente15");
        request.getSession(false).removeAttribute("dente14");
        request.getSession(false).removeAttribute("dente13");
        request.getSession(false).removeAttribute("dente12");
        request.getSession(false).removeAttribute("dente11");
        request.getSession(false).removeAttribute("dente21");
        request.getSession(false).removeAttribute("dente22");
        request.getSession(false).removeAttribute("dente23");
        request.getSession(false).removeAttribute("dente24");
        request.getSession(false).removeAttribute("dente25");
        request.getSession(false).removeAttribute("dente26");
        request.getSession(false).removeAttribute("dente27");
        request.getSession(false).removeAttribute("dente28");
        request.getSession(false).removeAttribute("dente31");
        request.getSession(false).removeAttribute("dente32");
        request.getSession(false).removeAttribute("dente33");
        request.getSession(false).removeAttribute("dente34");
        request.getSession(false).removeAttribute("dente35");
        request.getSession(false).removeAttribute("dente36");
        request.getSession(false).removeAttribute("dente37");
        request.getSession(false).removeAttribute("dente38");
        request.getSession(false).removeAttribute("dente48");
        request.getSession(false).removeAttribute("dente47");
        request.getSession(false).removeAttribute("dente46");
        request.getSession(false).removeAttribute("dente45");
        request.getSession(false).removeAttribute("dente44");
        request.getSession(false).removeAttribute("dente43");
        request.getSession(false).removeAttribute("dente42");
        request.getSession(false).removeAttribute("dente41");
        // idDente, colocado na sessao por VisualizarHistoricoDenteAction
        request.getSession(false).removeAttribute("idDente");
        // idBoca, colocado na sessao por VisualizarHistoricoBocaAction
        request.getSession(false).removeAttribute("idBoca");
        // idPaciente, colocado na sessao por AtenderAtendimentoOrcamentoAction ou ContinarAtendimentoOrcamentoAction
        request.getSession(false).removeAttribute("idPaciente");
        return mapping.findForward(SUCESSO);
    }
}