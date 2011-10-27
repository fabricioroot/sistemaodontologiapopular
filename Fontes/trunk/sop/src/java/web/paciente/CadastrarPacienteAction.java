package web.paciente;

import annotations.Boca;
import annotations.Endereco;
import annotations.Ficha;
import annotations.Paciente;
import dao.PessoaDAO;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.BocaService;
import service.FichaService;
import service.PacienteService;

/**
 *
 * @author Fabricio Reis
 */
public class CadastrarPacienteAction extends org.apache.struts.action.Action {
    
    private static final String SUCESSO = "sucesso";
    private static final String FALHASALVAR = "falhaSalvar";
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

        CadastrarPacienteActionForm formPaciente =  (CadastrarPacienteActionForm) form;

        PessoaDAO pessoaDAO = new PessoaDAO();

        if ((formPaciente.getNome().trim().isEmpty()) || (formPaciente.getDataNascimento().trim().isEmpty()) || (formPaciente.getLogradouro().trim().isEmpty())
            /*|| (formPaciente.getNumero().trim().isEmpty())*/ || (formPaciente.getBairro().trim().isEmpty()) || (formPaciente.getCidade().trim().isEmpty())
            || (formPaciente.getEstado().trim().isEmpty()) || (formPaciente.getIndicacao().trim().isEmpty())
            || (formPaciente.getIndicacao().trim().equals("selected") && formPaciente.getIndicacaoOutra().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        try {
            // Verifica se existe cadastro com o mesmo CPF digitado no formulario
            if (!formPaciente.getCpf().trim().isEmpty()) {
                if (!pessoaDAO.validarCpf(formPaciente.getCpf().trim())) {
                    return mapping.findForward(CPFJAEXISTE);
                }
            }

            // Verifica se existe cadastro com o mesmo RG digitado no formulario
            if (!formPaciente.getRg().isEmpty()) {
                if (!pessoaDAO.validarRg(formPaciente.getRg().trim())) {
                    return mapping.findForward(RGJAEXISTE);
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
            System.out.println("Falha ao formatar a data de nascimento de paciente em cadastro! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }

        Endereco endereco = new Endereco();
        endereco.setLogradouro(formPaciente.getLogradouro().trim());
        endereco.setNumero(formPaciente.getNumero().trim());
        endereco.setBairro(formPaciente.getBairro().trim());
        endereco.setComplemento(formPaciente.getComplemento().trim());
        endereco.setCidade(formPaciente.getCidade().trim());
        endereco.setEstado(formPaciente.getEstado().trim());
        endereco.setCep(formPaciente.getCep().trim());

        Paciente paciente = new Paciente();
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
            paciente.setRg(formPaciente.getRg());
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
        if (formPaciente.getIndicacao().trim().equals("selected")) {
            paciente.setIndicacao(formPaciente.getIndicacaoOutra().trim());
        }
        else {
            paciente.setIndicacao(formPaciente.getIndicacao().trim());
        }
        paciente.setStatus(formPaciente.getStatus());
        paciente.setImpedimento("");
        paciente.setFilaOrcamento(Boolean.FALSE);
        paciente.setFilaTratamento(Boolean.FALSE);

        // Cria um objeto boca associado ao paciente passado como parametro
        Boca boca = BocaService.getBoca(paciente);
        if (boca == null) {
            return mapping.findForward(FALHASALVAR);
        }

        // Associa a boca ao paciente
        paciente.setBoca(boca);

        // Cria um objeto ficha associado o paciente passado como parametro
        Ficha ficha = FichaService.getFicha(paciente);
        if (ficha == null) {
            return mapping.findForward(FALHASALVAR);
        }
        // Associa a ficha ao paciente
        paciente.setFicha(ficha);

        Integer id = PacienteService.salvar(paciente);
        if(id != null) {
            System.out.println("Registro de Paciente (ID = " + id + ") salvo com sucesso!");
            request.setAttribute("idPaciente", id.toString()); // Usado em VisualizarPacienteAction
            request.setAttribute("recemCadastrado", true);  // flag para nao exibir opcao "enviar para tratamento" na pagina visualizarPaciente.jsp
            request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarPaciente.jsp
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao salvar registro de paciente no banco!");
            return mapping.findForward(FALHASALVAR);
        }
    }
}
