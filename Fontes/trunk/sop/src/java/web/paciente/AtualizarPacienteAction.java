package web.paciente;

import annotations.Endereco;
import annotations.Paciente;
import dao.PessoaDAO;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.PacienteService;

/**
 *
 * @author Fabricio Reis
 */
public class AtualizarPacienteAction extends org.apache.struts.action.Action {
    
    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAVALIDAR = "falhaValidar";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
    private static final String CPFJAEXISTE = "cpfJaExiste";
    private static final String RGJAEXISTE = "rgJaExiste";
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

        AtualizarPacienteActionForm formPaciente =  (AtualizarPacienteActionForm) form;

        PessoaDAO pessoaDAO = new PessoaDAO();
        
        if ((formPaciente.getNome().trim().isEmpty()) || (formPaciente.getDataNascimento().trim().isEmpty()) || (formPaciente.getLogradouro().trim().isEmpty())
            /*|| (formPaciente.getNumero().trim().isEmpty())*/ || (formPaciente.getBairro().trim().isEmpty()) || (formPaciente.getCidade().trim().isEmpty())
            || (formPaciente.getEstado().trim().isEmpty()) || (formPaciente.getIndicacao().trim().isEmpty())
            || (formPaciente.getIndicacao().trim().equals("Outra") && formPaciente.getIndicacaoOutra().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        try {
            // Verifica se o usuario editou o cpf buscando no banco se existe registro com o id e cpf passados como parametros
            if (!formPaciente.getCpf().trim().isEmpty()) {
                if (!pessoaDAO.validarEditarCpf(formPaciente.getCpf().trim(), formPaciente.getId())) {
                    if (!pessoaDAO.validarCpf(formPaciente.getCpf().trim())) {
                        return mapping.findForward(CPFJAEXISTE);
                    }
                }
            }

            // Verifica se o usuario editou o rg buscando no banco se existe registro com o id e rg passados como parametros
            if (!formPaciente.getRg().trim().isEmpty()) {
                if (!pessoaDAO.validarEditarRg(formPaciente.getRg().trim(), formPaciente.getId())) {
                    if (!pessoaDAO.validarRg(formPaciente.getRg().trim())) {
                        return mapping.findForward(RGJAEXISTE);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Falha ao validar dados unicos de paciente no banco de dados! Exception: " + e.getMessage());
            return mapping.findForward(FALHAVALIDAR);
        }

        Date dataNascimento = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            dataNascimento = formatador.parse(formPaciente.getDataNascimento());
        } catch (Exception e) {
            System.out.println("Falha ao formatar a data de nascimento de paciente em atualizacao! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }

        Endereco endereco = new Endereco();
        endereco.setId(formPaciente.getEnderecoId());
        endereco.setLogradouro(formPaciente.getLogradouro().trim());
        endereco.setNumero(formPaciente.getNumero().trim());
        endereco.setBairro(formPaciente.getBairro().trim());
        endereco.setComplemento(formPaciente.getComplemento().trim());
        endereco.setCidade(formPaciente.getCidade().trim());
        endereco.setEstado(formPaciente.getEstado().trim());
        endereco.setCep(formPaciente.getCep().trim());

        Paciente paciente = new Paciente();
        paciente.setId(formPaciente.getId());
        paciente.setNome(formPaciente.getNome().trim());
        paciente.setSexo(formPaciente.getSexo());
        // Verificacao do CPF para garantir que serah passado null caso o campo nao esteja preenchido
        if (formPaciente.getCpf().trim().isEmpty()) {
            paciente.setCpf(null);
        }
        else {
            paciente.setCpf(formPaciente.getCpf().trim());
        }
        // Verificacao do RG para garantir que serah passado null caso o campo nao esteja preenchido
        if (formPaciente.getRg().trim().isEmpty()) {
            paciente.setRg(null);
        }
        else {
            paciente.setRg(formPaciente.getRg().trim());
        }
        paciente.setDataNascimento(dataNascimento);
        paciente.setEstadoCivil(formPaciente.getEstadoCivil().trim());
        paciente.setNomePai(formPaciente.getNomePai().trim());
        paciente.setNomeMae(formPaciente.getNomeMae().trim());
        endereco.setPessoa(paciente);
        paciente.setEndereco(endereco);
        paciente.setTelefoneFixo(formPaciente.getTelefoneFixo().trim());
        paciente.setTelefoneCelular(formPaciente.getTelefoneCelular().trim());
        paciente.setEmail(formPaciente.getEmail().trim());
        paciente.setStatus(formPaciente.getStatus());
        if (formPaciente.getIndicacao().trim().equals("selected")) {
            paciente.setIndicacao(formPaciente.getIndicacaoOutra().trim());
        }
        else {
            paciente.setIndicacao(formPaciente.getIndicacao().trim());
        }
        paciente.setImpedimento(formPaciente.getImpedimento());
        paciente.setFilaOrcamento(formPaciente.isFilaOrcamento());
        paciente.setFilaTratamento(formPaciente.isFilaTratamento());

        if(PacienteService.atualizar(paciente)) {
            System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") atualizado com sucesso!");
            request.setAttribute("idPaciente", paciente.getId().toString()); // Usado em VisualizarPacienteAction
            request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarPaciente.jsp
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de paciente (ID = " + paciente.getId() + ") no banco!");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}