package web.caixa;

import annotations.Ficha;
import annotations.Paciente;
import annotations.Pagamento;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.FichaService;
import service.PagamentoService;

/**
 *
 * @author Fabricio Reis
 */
public class ListarPagamentosAction extends org.apache.struts.action.Action {

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
        // Captura o id do paciente que vem da pagina consultarPacienteParaDevolucaoDinheiro.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
            Paciente paciente = new Paciente(Integer.parseInt(idPaciente));
            ficha = FichaService.getFicha(paciente);
            if (ficha == null) {
                System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em ListarPagamentosAction");
                return mapping.findForward(FALHACONSULTAR);
            }
        }
        else {
            System.out.println("Falha ao capturar id do paciente em ListarPagamentosAction.");
            return mapping.findForward(FALHAIDENTIFICARFICHA);
        }

        // Coloca o objeto 'paciente' no request
        request.setAttribute("paciente", ficha.getPaciente());

        // Busca registros de pagamentos e cria objeto (Collection<Pagamento>)
        Collection<Pagamento> pagamentoCollection = PagamentoService.getPagamentos(ficha);
        if (pagamentoCollection == null) {
            System.out.println("Falha ao buscar registros de Pagamento em ListarPagamentosAction");
            return mapping.findForward(FALHACONSULTAR);
        }
        request.setAttribute("pagamentoCollection", pagamentoCollection);

        return mapping.findForward(SUCESSO);
    }
}