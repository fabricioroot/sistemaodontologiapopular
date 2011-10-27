package web.caixa;

import annotations.Ficha;
import annotations.Paciente;
import annotations.Pagamento;
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
public class DevolverDinheiroAction extends org.apache.struts.action.Action {

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
        // Captura o id do paciente que vem da pagina listarPagamentos.jsp
        String idPaciente = "";
        if (request.getParameter("idPaciente") != null) {
            idPaciente = request.getParameter("idPaciente");
            Paciente paciente = new Paciente(Integer.parseInt(idPaciente));
            ficha = FichaService.getFicha(paciente);
            if (ficha == null) {
                System.out.println("Registro de Ficha do paciente de ID: " + idPaciente + " NAO encontrado em DevolverDinheiroAction");
                return mapping.findForward(FALHACONSULTAR);
            }
        }
        else {
            System.out.println("Falha ao capturar ID de Paciente em DevolverDinheiroAction.");
            return mapping.findForward(FALHAIDENTIFICARFICHA);
        }

        // Coloca o objeto 'ficha' no request
        request.setAttribute("ficha", ficha);

        // Busca registro de pagamento a partir do id recebido da pagina listarPagamentos.jsp e instancia objeto Pagamento
        Pagamento pagamento = null;
        String idPagamento = "";
        if (request.getParameter("idPagamento") != null) {
            idPagamento = request.getParameter("idPagamento");
            pagamento = PagamentoService.getPagamento(Integer.parseInt(idPagamento));
        }
        if (pagamento == null) {
            System.out.println("Falha ao buscar registros de Pagamento em DevolverDinheiroAction");
            return mapping.findForward(FALHACONSULTAR);
        }
        request.setAttribute("pagamento", pagamento);

        return mapping.findForward(SUCESSO);
    }
}