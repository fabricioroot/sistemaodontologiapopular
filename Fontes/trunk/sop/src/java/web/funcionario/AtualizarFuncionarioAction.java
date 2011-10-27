package web.funcionario;

import annotations.Dentista;
import annotations.Endereco;
import annotations.Funcionario;
import annotations.GrupoAcesso;
import dao.DentistaDAO;
import dao.FuncionarioDAO;
import dao.PessoaDAO;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
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
public class AtualizarFuncionarioAction extends org.apache.struts.action.Action {
    
    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAINSERIRDENTISTA = "falhaInserirDentista";
    private static final String FALHAVALIDAR = "falhaValidar";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
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

        AtualizarFuncionarioActionForm formFuncionario =  (AtualizarFuncionarioActionForm) form;

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

        try {
            // Verifica se o usuario editou o nomeDeUsuario buscando no banco se existe registro com o id e nomeDeUsuario passados como parametros
            if (!funcionarioDAO.validarEditarNomeDeUsuario(formFuncionario.getNomeDeUsuario().trim(), formFuncionario.getId())) {
                if (!funcionarioDAO.validarNomeDeUsuario(formFuncionario.getNomeDeUsuario().trim())) {
                    return mapping.findForward(NOMEDEUSUARIOJAEXISTE);
                }
            }

            // Verifica se o usuario editou o cpf buscando no banco se existe registro com o id e cpf passados como parametros
            if (!pessoaDAO.validarEditarCpf(formFuncionario.getCpf().trim(), formFuncionario.getId())) {
                if (!pessoaDAO.validarCpf(formFuncionario.getCpf().trim())) {
                    return mapping.findForward(CPFJAEXISTE);
                }
            }

            // Verifica se o usuario editou o rg buscando no banco se existe registro com o id e rg passados como parametros
            if (!formFuncionario.getRg().trim().isEmpty()) {
                if (!pessoaDAO.validarEditarRg(formFuncionario.getRg().trim(), formFuncionario.getId())) {
                    if (!pessoaDAO.validarRg(formFuncionario.getRg().trim())) {
                        return mapping.findForward(RGJAEXISTE);
                    }
                }
            }

            // Verifica se o usuario editou o cro buscando no banco se existe registro com o id e cro passados como parametros
            if (!formFuncionario.getCroOrcamento().trim().isEmpty()) {
                if (!dentistaDAO.validarEditarCro(formFuncionario.getCroOrcamento().trim(), formFuncionario.getId())) {
                    if (!dentistaDAO.validarCro(formFuncionario.getCroOrcamento().trim())) {
                        return mapping.findForward(CROJAEXISTE);
                    }
                }
            }

            // Verifica se o usuario editou o cro buscando no banco se existe registro com o id e cro passados como parametros
            if (!formFuncionario.getCroTratamento().trim().isEmpty()) {
                if (!dentistaDAO.validarEditarCro(formFuncionario.getCroTratamento().trim(), formFuncionario.getId())) {
                    if (!dentistaDAO.validarCro(formFuncionario.getCroTratamento().trim())) {
                        return mapping.findForward(CROJAEXISTE);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Falha ao validar dados unicos de funcionario no banco de dados! Exception: " + e.getMessage());
            return mapping.findForward(FALHAVALIDAR);
        }

        // Instancia objeto Set com os grupos de acesso marcados no formulario
        String[] gruposAcesso = formFuncionario.getGrupoAcesso();
        Set<GrupoAcesso> grupoAcessoSet = new HashSet<GrupoAcesso>();
        grupoAcessoSet = GrupoAcessoService.getGruposAcesso(gruposAcesso);

        // Usado para distinguir funcionario com cargo de dentista
        String cargo = formFuncionario.getCargo();

        Date dataNascimento = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            dataNascimento = formatador.parse(formFuncionario.getDataNascimento());
        } catch (Exception e) {
            System.out.println("Falha ao formatar a data de nascimento de funcionario em atualizacao! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }

        Endereco endereco = new Endereco();
        endereco.setId(formFuncionario.getEnderecoId());
        endereco.setLogradouro(formFuncionario.getLogradouro().trim());
        endereco.setNumero(formFuncionario.getNumero().trim());
        endereco.setBairro(formFuncionario.getBairro().trim());
        endereco.setComplemento(formFuncionario.getComplemento().trim());
        endereco.setCidade(formFuncionario.getCidade().trim());
        endereco.setEstado(formFuncionario.getEstado().trim());
        endereco.setCep(formFuncionario.getCep().trim());

        // Se nao for/serah dentista
        if (!cargo.equals("Dentista-Orcamento") && !cargo.equals("Dentista-Tratamento") && !cargo.equals("Dentista-Orcamento-Tratamento")) {
            Funcionario funcionario = new Funcionario();
            funcionario.setId(formFuncionario.getId());
            funcionario.setNome(formFuncionario.getNome().trim());
            funcionario.setSexo(formFuncionario.getSexo());
            funcionario.setCargo(formFuncionario.getCargo().trim());
            // Verificacao do CPF para garantir que serah passado null caso o formulario nao esteja preenchido
            if (formFuncionario.getCpf().trim().isEmpty()) {
                funcionario.setCpf(null);
            }
            else {
                funcionario.setCpf(formFuncionario.getCpf().trim());
            }
            // Verificacao do RG para garantir que serah passado null caso o formulario nao esteja preenchido
            if (formFuncionario.getRg().trim().isEmpty()) {
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
            funcionario.setNomeDeUsuario(formFuncionario.getNomeDeUsuario().trim().toLowerCase());
            // TO DO aplicar hash na senha
            funcionario.setSenha(formFuncionario.getSenha().trim().toLowerCase());
            funcionario.setFraseEsqueciMinhaSenha(formFuncionario.getFraseEsqueciMinhaSenha().trim());
            funcionario.setGrupoAcessoSet(grupoAcessoSet);
            funcionario.setStatus(formFuncionario.getStatus());
            // >>>>>>>>>>>>>>>>>>>> TO DO Codigo de Autenticacao
            funcionario.setCodigoAutenticacao("123");

            if(FuncionarioService.atualizar(funcionario)) {
                System.out.println("Registro de Funcionario (ID = " + funcionario.getId() + ") atualizado com sucesso!");
                request.setAttribute("idFuncionario", funcionario.getId().toString()); // Usado em VisualizarFuncionarioAction
            }
            else {
                System.out.println("Falha ao atualizar registro de Funcionario (ID = " + funcionario.getId() + ") no banco!");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        else { // Eh/Serah dentista
            Dentista dentista = new Dentista();
            dentista.setId(formFuncionario.getId());
            // Verificacao para quando for atualizar um funcionario que nunca foi dentista
            if (dentista == null) {
                dentista = new Dentista();
                dentista.setId(formFuncionario.getId());
            }
            dentista.setNome(formFuncionario.getNome().trim());
            dentista.setSexo(formFuncionario.getSexo());
            dentista.setCargo(formFuncionario.getCargo().trim());
            // Verificacao do CPF para garantir que serah passado null caso o formulario nao esteja preenchido
            if (formFuncionario.getCpf().trim().isEmpty()) {
                dentista.setCpf(null);
            }
            else {
                dentista.setCpf(formFuncionario.getCpf().trim());
            }
            // Verificacao do RG para garantir que serah passado null caso o formulario nao esteja preenchido
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
                // Verificacao do CRO para garantir que serah passado null caso o formulario nao esteja preenchido
                if (formFuncionario.getCroTratamento().trim().isEmpty()) {
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
                // Verificacao do CRO para garantir que serah passado null caso o formulario nao esteja preenchido
                if (formFuncionario.getCroOrcamento().trim().isEmpty()) {
                    dentista.setCro(null);
                }
                else {
                    dentista.setCro(formFuncionario.getCroOrcamento().trim());
                }
                dentista.setEspecialidade(formFuncionario.getEspecialidadeOrcamento().trim());
                dentista.setComissaoOrcamento(formFuncionario.getComissaoOrcamento());
                dentista.setComissaoTratamento(Double.parseDouble("0"));
            }
            if (cargo.equals("Dentista-Orcamento-Tratamento")) { // Ambos (dentista de tratamento e orcamento)
                // Verificacao do CRO para garantir que serah passado null caso o formulario nao esteja preenchido
                if (formFuncionario.getCroOrcamento().trim().isEmpty()) {
                    dentista.setCro(null);
                }
                else {
                    dentista.setCro(formFuncionario.getCroOrcamentoTratamento().trim());
                }
                dentista.setEspecialidade(formFuncionario.getEspecialidadeOrcamentoTratamento().trim());
                dentista.setComissaoOrcamento(formFuncionario.getComissaoOrcamentoTratamento());
                dentista.setComissaoTratamento(formFuncionario.getComissaoTratamentoOrcamento());
            }

            // Trecho de codigo para tratar o caso de um funcionario que nunca foi dentista passe a ser um...
            // Captura objeto funcionarioAux na sessao
            // Este objeto eh colocado na sessao pela pagina editarFuncionario
            Funcionario funcionarioAux = (Funcionario)request.getSession().getAttribute("funcionarioAux");
            if (funcionarioAux != null) {
                // Verifica se o funcionario que estah sendo editado nao eh dentista e, neste caso, estah sendo editado para ser um
                // Assim, deve-se inserir registro de dentista para nao ocorrer erro durante a atualizacao dos dados
                if ((!funcionarioAux.getCargo().equals("Dentista-Orcamento")) || (!funcionarioAux.getCargo().equals("Dentista-Tratamento")) || (!funcionarioAux.getCargo().equals("Dentista-Orcamento-Tratamento"))) {
                    try {
                        // Antes de inserir, verifica se ja nao existe o registro. Ou seja, se o funcionario foi dentista um dia...
                        if (!dentistaDAO.validarId(dentista.getId())) {
                            dentistaDAO.inserirRegistroDentista(dentista.getId(), dentista.getCro(), dentista.getEspecialidade(), dentista.getComissaoOrcamento(), dentista.getComissaoTratamento());
                        }
                    } catch (Exception e) {
                        System.out.println("Falha ao inserir registro de dentista no banco ao atualizar cargo de funcionario comum para dentista. Exception: " + e.getMessage());
                        return mapping.findForward(FALHAINSERIRDENTISTA);
                    }
                }
            }

            if(DentistaService.atualizar(dentista)) {
                System.out.println("Registro de Dentista (ID = " + dentista.getId() + ") atualizado com sucesso!");
                request.setAttribute("idFuncionario", dentista.getId().toString()); // Usado em VisualizarFuncionarioAction
            }
            else {
                System.out.println("Falha ao atualizar registro de dentista (ID = " + dentista.getId() + ") no banco!");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        // Remove o objeto funcionarioAux da sessao (colocado pela pagina editarFuncionario)
        request.getSession(false).removeAttribute("funcionarioAux");
        request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarFuncionario.jsp
        return mapping.findForward(SUCESSO);
    }
}