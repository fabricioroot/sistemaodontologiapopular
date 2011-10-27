package web.paciente;

import annotations.Paciente;
import dao.PacienteDAO;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarPacienteAction extends org.apache.struts.action.Action {
    
    private static final String SUCESSO = "sucesso";
    private static final String FALHACONSULTAR = "falhaConsultar";
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

        ConsultarPacienteActionForm formPaciente =  (ConsultarPacienteActionForm) form;

        Integer opcao = formPaciente.getOpcao();
        PacienteDAO pacienteDAO = new PacienteDAO();
        List<Paciente> resultado = new ArrayList();

        try {
            switch (opcao) {
                case 0: // Pesquisa pelo nome
                    resultado = pacienteDAO.consultarNome(formPaciente.getNome().trim());
                    break;
                case 1: // Pesquisa pelo cpf
                    if (!formPaciente.getCpf().isEmpty()) {
                        resultado = pacienteDAO.consultarCpf(formPaciente.getCpf().trim());
                    }
                    else {
                        resultado = pacienteDAO.consultarCpf("");
                    }
                    break;
                case 2: // Pesquisa pelo logradouro
                    resultado = pacienteDAO.consultarLogradouro(formPaciente.getLogradouro().trim());
                    break;
                case 3: // Pesquisa pelo codigo/id
                    if (!formPaciente.getCodigo().isEmpty()) {
                        resultado = pacienteDAO.consultarId(Integer.parseInt(formPaciente.getCodigo().trim()));
                    }
                    else {
                        resultado = pacienteDAO.consultarId(null);
                    }
                    break;
                default:
                    System.out.println("Opcao de pesquisa em consultar paciente nao encontrada!");
                    resultado = null;
            }
            request.setAttribute("resultado", resultado);

        } catch (Exception e) {
            System.out.println("Falha ao consultar dados de pacientes no banco! Exception: " + e.getMessage());
            return mapping.findForward(FALHACONSULTAR);
        }
        return mapping.findForward(SUCESSO);
    }
}
