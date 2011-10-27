package web.procedimento;

import annotations.Procedimento;
import dao.ProcedimentoDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ProcedimentoService;

/**
 *
 * @author Fabricio Reis
 */
public class AtualizarProcedimentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAVALIDAR = "falhaValidar";
    private static final String NOMEPROCEDIMENTOJAEXISTE = "nomeProcedimentoJaExiste";
    private static final String DESCRICAOPROCEDIMENTOJAEXISTE = "descricaoProcedimentoJaExiste";
    private static final String VALORMINIMOINVALIDO = "valorMinimoInvalido";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
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

        AtualizarProcedimentoActionForm formProcedimento =  (AtualizarProcedimentoActionForm) form;

        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();

        if ((formProcedimento.getNome().trim().isEmpty()) || (formProcedimento.getDescricao().trim().isEmpty())
            || (formProcedimento.getValor().toString().trim().isEmpty()) || (formProcedimento.getValorMinimo().toString().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        if (formProcedimento.getValor() < formProcedimento.getValorMinimo()) {
            return mapping.findForward(VALORMINIMOINVALIDO);
        }

        try {
            // Verifica se o usuario editou o nome buscando no banco se existe registro com o id e nome passados como parametros
            if (!formProcedimento.getNome().trim().isEmpty()) {
                if (!procedimentoDAO.validarEditarNome(formProcedimento.getNome().trim(), formProcedimento.getId())) {
                    if (!procedimentoDAO.validarNome(formProcedimento.getNome().trim())) {
                        return mapping.findForward(NOMEPROCEDIMENTOJAEXISTE);
                    }
                }
            }

            // Verifica se o usuario editou a descricao buscando no banco se existe registro com o id e descricao passados como parametros
            if (!formProcedimento.getDescricao().trim().isEmpty()) {
                if (!procedimentoDAO.validarEditarDescricao(formProcedimento.getDescricao().trim(), formProcedimento.getId())) {
                    if (!procedimentoDAO.validarDescricao(formProcedimento.getDescricao().trim())) {
                        return mapping.findForward(DESCRICAOPROCEDIMENTOJAEXISTE);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Falha ao validar dados unicos de procedimento no banco de dados! Exception: " + e.getMessage());
            return mapping.findForward(FALHAVALIDAR);
        }

        Procedimento procedimento = new Procedimento();
        procedimento.setId(formProcedimento.getId());
        procedimento.setNome(formProcedimento.getNome().trim());
        procedimento.setDescricao(formProcedimento.getDescricao().trim());
        procedimento.setSimbolo(formProcedimento.getSimbolo().trim());
        procedimento.setValor(formProcedimento.getValor());
        procedimento.setValorMinimo(formProcedimento.getValorMinimo());
        procedimento.setStatus(formProcedimento.getStatus());
        procedimento.setTipo(formProcedimento.getTipo().trim());

        if(ProcedimentoService.atualizar(procedimento)) {
            System.out.println("Registro de Procedimento (ID = " + procedimento.getId() + ") atualizado com sucesso!");
            request.setAttribute("idProcedimento", procedimento.getId().toString()); // Usado em VisualizarProcedimentoAction
            request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarProcedimento.jsp
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de Procedimento (ID = " + procedimento.getId() + ") no banco!");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}