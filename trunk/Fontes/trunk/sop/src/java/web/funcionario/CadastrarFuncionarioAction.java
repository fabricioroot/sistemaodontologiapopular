package web.funcionario;

import annotations.Dentista;
import annotations.Endereco;
import annotations.Funcionario;
import annotations.GrupoAcesso;
import dao.DentistaDAO;
import dao.FuncionarioDAO;
import dao.PessoaDAO;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.DentistaService;
import service.FuncionarioService;
import service.GrupoAcessoService;

/**
 *
 * @author Fabricio Reis
 */
public class CadastrarFuncionarioAction extends org.apache.struts.action.Action {
    
    private static final String SUCESSO = "sucesso";
    private static final String FALHASALVAR = "falhaSalvar";
    private static final String FALHAVALIDAR = "falhaValidar";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
    private static final String FALHACONSULTARGRUPOACESSO = "falhaConsultarGrupoAcesso";
    private static final String NOMEDEUSUARIOJAEXISTE = "nomeDeUsuarioJaExiste";
    private static final String CPFJAEXISTE = "cpfJaExiste";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
    private static final String RGJAEXISTE = "rgJaExiste";
    private static final String CROJAEXISTE = "croJaExiste";
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

        CadastrarFuncionarioActionForm formFuncionario =  (CadastrarFuncionarioActionForm) form;

        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        PessoaDAO pessoaDAO = new PessoaDAO();
        DentistaDAO dentistaDAO = new DentistaDAO();

        if ( (formFuncionario.getNome().trim().isEmpty()) || (formFuncionario.getCargo().trim().isEmpty()) || (formFuncionario.getCpf().trim().isEmpty())
            || (formFuncionario.getDataNascimento().trim().isEmpty()) || (formFuncionario.getLogradouro().trim().isEmpty()) /*|| (formFuncionario.getNumero().trim().isEmpty())*/
            || (formFuncionario.getBairro().trim().isEmpty()) || (formFuncionario.getCidade().trim().isEmpty()) || (formFuncionario.getEstado().trim().isEmpty())
            || (formFuncionario.getNomeDeUsuario().trim().isEmpty()) || (formFuncionario.getSenha().trim().isEmpty()) || (formFuncionario.getComissaoTratamento().toString().trim().isEmpty())
            || (formFuncionario.getComissaoOrcamento().toString().trim().isEmpty()) || (formFuncionario.getComissaoOrcamentoTratamento().toString().trim().isEmpty())
            || (formFuncionario.getComissaoTratamentoOrcamento().toString().trim().isEmpty()) || (formFuncionario.getGrupoAcesso().length <= 0)) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        Integer id;
        try {
            // Verifica se existe cadastro com o mesmo nome de usuario digitado no formulario
            if (!funcionarioDAO.validarNomeDeUsuario(formFuncionario.getNomeDeUsuario().trim())) {
                return mapping.findForward(NOMEDEUSUARIOJAEXISTE);
            }

            // Verifica se existe cadastro com o mesmo CPF digitado no formulario
            if (!pessoaDAO.validarCpf(formFuncionario.getCpf().trim())) {
                return mapping.findForward(CPFJAEXISTE);
            }

            // Verifica se existe cadastro com o mesmo RG digitado no formulario
            if (!formFuncionario.getRg().trim().isEmpty()) {
                if (!pessoaDAO.validarRg(formFuncionario.getRg().trim())) {
                    return mapping.findForward(RGJAEXISTE);
                }
            }

            // Verifica se existe cadastro com o mesmo CRO digitado no formulario
            if (!formFuncionario.getCroOrcamento().trim().isEmpty()) {
                if (!dentistaDAO.validarCro(formFuncionario.getCroOrcamento().trim())) {
                    return mapping.findForward(CROJAEXISTE);
                }
            }

            // Verifica se existe cadastro com o mesmo CRO digitado no formulario
            if (!formFuncionario.getCroTratamento().trim().isEmpty()) {
                if (!dentistaDAO.validarCro(formFuncionario.getCroTratamento().trim())) {
                    return mapping.findForward(CROJAEXISTE);
                }
            }

            // Verifica se existe cadastro com o mesmo CRO digitado no formulario
            if (!formFuncionario.getCroOrcamentoTratamento().trim().isEmpty()) {
                if (!dentistaDAO.validarCro(formFuncionario.getCroOrcamentoTratamento().trim())) {
                    return mapping.findForward(CROJAEXISTE);
                }
            }
        } catch (Exception e) {
            System.out.println("Falha ao validar dados unicos de funcionario no banco de dados! Exception: " + e.getMessage());
            return mapping.findForward(FALHAVALIDAR);
        }

        String[] gruposAcesso = formFuncionario.getGrupoAcesso();
        Set<GrupoAcesso> grupoAcessoSet = new HashSet<GrupoAcesso>();
        grupoAcessoSet = GrupoAcessoService.getGruposAcesso(gruposAcesso);

        if (grupoAcessoSet.isEmpty()) {
            System.out.println("Registros de grupos de acesso NAO encontrados em CadastrarFuncionarioAction! Possivelmente nao marcou nenhum.");
            return mapping.findForward(FALHACONSULTARGRUPOACESSO);
        }

        // Usado para distinguir funcionario com cargo de dentista
        String cargo = formFuncionario.getCargo().trim();

        Date dataNascimento = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            dataNascimento = formatador.parse(formFuncionario.getDataNascimento());
        } catch (Exception e) {
            System.out.println("Falha ao formatar a data de nascimento de funcionario em cadastro! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }

        Endereco endereco = new Endereco();
        endereco.setLogradouro(formFuncionario.getLogradouro().trim());
        endereco.setNumero(formFuncionario.getNumero().trim());
        endereco.setBairro(formFuncionario.getBairro().trim());
        endereco.setComplemento(formFuncionario.getComplemento().trim());
        endereco.setCidade(formFuncionario.getCidade().trim());
        endereco.setEstado(formFuncionario.getEstado().trim());
        endereco.setCep(formFuncionario.getCep().trim());

        // Se nao for dentista
        if (!cargo.equals("Dentista-Orcamento") && !cargo.equals("Dentista-Tratamento") && !cargo.equals("Dentista-Orcamento-Tratamento")) {
            Funcionario funcionario = new Funcionario();
            funcionario.setNome(formFuncionario.getNome().trim());
            funcionario.setSexo(formFuncionario.getSexo());
            funcionario.setCargo(formFuncionario.getCargo().trim());
            funcionario.setCpf(formFuncionario.getCpf().trim());
            // Verificacao do RG para garantir que serah passado null caso o campo nao esteja preenchido
            if (formFuncionario.getRg().trim().equals("")) {
                funcionario.setRg(null);
            }
            else {
                funcionario.setRg(formFuncionario.getRg().trim());
            }
            funcionario.setDataNascimento(dataNascimento);
            funcionario.setEstadoCivil(formFuncionario.getEstadoCivil().trim());
            endereco.setPessoa(funcionario);
            funcionario.setEndereco(endereco);
            funcionario.setTelefoneFixo(formFuncionario.getTelefoneFixo().trim());
            funcionario.setTelefoneCelular(formFuncionario.getTelefoneCelular().trim());
            funcionario.setEmail(formFuncionario.getEmail().trim());
            funcionario.setNomeDeUsuario(formFuncionario.getNomeDeUsuario().trim());
            // TO DO aplicar hash na senha
            funcionario.setSenha(formFuncionario.getSenha().trim().toLowerCase());
            funcionario.setFraseEsqueciMinhaSenha(formFuncionario.getFraseEsqueciMinhaSenha().trim());
            funcionario.setGrupoAcessoSet(grupoAcessoSet);
            funcionario.setStatus(formFuncionario.getStatus());
            // >>>>>>>>>>>>>>>>>>>> TO DO Codigo de Autenticacao
            funcionario.setCodigoAutenticacao("123");

            id = FuncionarioService.salvar(funcionario);
            if(id != null) {
                System.out.println("Registro de Funcionario (ID = " + id + ") salvo com sucesso!");
            }
            else {
                System.out.println("Falha ao salvar registro de Funcionario no banco!");
                return mapping.findForward(FALHASALVAR);
            }
        }
        else { // Eh dentista
            Dentista dentista = new Dentista();
            dentista.setNome(formFuncionario.getNome().trim());
            dentista.setSexo(formFuncionario.getSexo());
            dentista.setCargo(formFuncionario.getCargo().trim());
            dentista.setCpf(formFuncionario.getCpf().trim());
            // Verificacao do RG para garantir que serah passado null caso o campo nao esteja preenchido
            if (formFuncionario.getRg().trim().equals("")) {
                dentista.setRg(null);
            }
            else {
                dentista.setRg(formFuncionario.getRg().trim());
            }
            dentista.setDataNascimento(dataNascimento);
            dentista.setEstadoCivil(formFuncionario.getEstadoCivil().trim());
            endereco.setPessoa(dentista);
            dentista.setEndereco(endereco);
            dentista.setTelefoneFixo(formFuncionario.getTelefoneFixo().trim());
            dentista.setTelefoneCelular(formFuncionario.getTelefoneCelular().trim());
            dentista.setEmail(formFuncionario.getEmail().trim());
            dentista.setNomeDeUsuario(formFuncionario.getNomeDeUsuario().trim());
            // TO DO aplicar hash na senha
            dentista.setSenha(formFuncionario.getSenha().trim().toLowerCase());
            dentista.setFraseEsqueciMinhaSenha(formFuncionario.getFraseEsqueciMinhaSenha().trim());
            dentista.setGrupoAcessoSet(grupoAcessoSet);
            dentista.setStatus(formFuncionario.getStatus());
            // >>>>>>>>>>>>>>>>>>>> TO DO Codigo de Autenticacao
            dentista.setCodigoAutenticacao("123");

            // Dentista de tratamento
            if (cargo.equals("Dentista-Tratamento")) {
                // Verificacao do CRO para garantir que serah passado null caso o campo nao esteja preenchido
                if (formFuncionario.getCroTratamento().trim().equals("")) {
                    dentista.setCro(null);
                }
                else {
                    dentista.setCro(formFuncionario.getCroTratamento().trim());
                }
                dentista.setEspecialidade(formFuncionario.getEspecialidadeTratamento().trim());
                dentista.setComissaoTratamento(formFuncionario.getComissaoTratamento());
                dentista.setComissaoOrcamento(Double.parseDouble("0"));
            }
            if (cargo.equals("Dentista-Orcamento")) { // Dentista de orcamento
                // Verificacao do CRO para garantir que serah passado null caso o campo nao esteja preenchido
                if (formFuncionario.getCroOrcamento().trim().equals("")) {
                    dentista.setCro(null);
                }
                else {
                    dentista.setCro(formFuncionario.getCroOrcamento().trim());
                }
                dentista.setEspecialidade(formFuncionario.getEspecialidadeOrcamento().trim());
                dentista.setComissaoOrcamento(formFuncionario.getComissaoOrcamento());
                dentista.setComissaoTratamento(Double.parseDouble("0"));
            }
            if (cargo.equals("Dentista-Orcamento-Tratamento")) { // Ambos (dentista de orcamento e tratamento)
                // Verificacao do CRO para garantir que serah passado null caso o campo nao esteja preenchido
                if (formFuncionario.getCroOrcamentoTratamento().trim().equals("")) {
                    dentista.setCro(null);
                }
                else {
                    dentista.setCro(formFuncionario.getCroOrcamentoTratamento().trim());
                }
                dentista.setEspecialidade(formFuncionario.getEspecialidadeOrcamentoTratamento().trim());
                dentista.setComissaoOrcamento(formFuncionario.getComissaoOrcamentoTratamento());
                dentista.setComissaoTratamento(formFuncionario.getComissaoTratamentoOrcamento());
            }

            id = DentistaService.salvar(dentista);
            if(id != null) {
                System.out.println("Registro de Dentista (ID = " + id + ") salvo com sucesso!");
            }
            else {
                System.out.println("Falha ao salvar registro de Dentista no banco!");
                return mapping.findForward(FALHASALVAR);
            }
        }
        request.setAttribute("idFuncionario", id.toString()); // Usado em VisualizarFuncionarioAction
        request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarFuncionario.jsp
        return mapping.findForward(SUCESSO);
    }
}