package web.funcionario;

/**
 *
 * @author Fabricio Reis
 */
public class AtualizarFuncionarioActionForm extends org.apache.struts.action.ActionForm {

    private Integer id;
    private String nome;
    private char sexo;
    private String estadoCivil;
    private Integer enderecoId;
    private String logradouro;
    private String numero;
    private String bairro;
    private String complemento;
    private String cidade;
    private String estado;
    private String cep;
    private String cpf;
    private String rg;
    private String dataNascimento;
    private String telefoneFixo;
    private String telefoneCelular;
    private String email;
    private String nomeDeUsuario;
    private String senha;
    private String fraseEsqueciMinhaSenha;
    private String cargo;
    private char status;
    private String codigoAutenticacao;
    private String croTratamento;
    private String croOrcamento;
    private String croOrcamentoTratamento;
    private String especialidadeTratamento;
    private String especialidadeOrcamento;
    private String especialidadeOrcamentoTratamento;
    private Double comissaoTratamento;
    private Double comissaoOrcamento;
    private Double comissaoTratamentoOrcamento;
    private Double comissaoOrcamentoTratamento;
    private String[] grupoAcesso;

    public AtualizarFuncionarioActionForm() {
    }

    public Integer getEnderecoId() {
        return enderecoId;
    }

    public void setEnderecoId(Integer enderecoId) {
        this.enderecoId = enderecoId;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getCodigoAutenticacao() {
        return codigoAutenticacao;
    }

    public void setCodigoAutenticacao(String codigoAutenticacao) {
        this.codigoAutenticacao = codigoAutenticacao;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getCroOrcamento() {
        return croOrcamento;
    }

    public void setCroOrcamento(String croOrcamento) {
        this.croOrcamento = croOrcamento;
    }

    public String getCroOrcamentoTratamento() {
        return croOrcamentoTratamento;
    }

    public void setCroOrcamentoTratamento(String croOrcamentoTratamento) {
        this.croOrcamentoTratamento = croOrcamentoTratamento;
    }

    public String getCroTratamento() {
        return croTratamento;
    }

    public void setCroTratamento(String croTratamento) {
        this.croTratamento = croTratamento;
    }

    public String getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(String dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEspecialidadeOrcamento() {
        return especialidadeOrcamento;
    }

    public void setEspecialidadeOrcamento(String especialidadeOrcamento) {
        this.especialidadeOrcamento = especialidadeOrcamento;
    }

    public String getEspecialidadeOrcamentoTratamento() {
        return especialidadeOrcamentoTratamento;
    }

    public void setEspecialidadeOrcamentoTratamento(String especialidadeOrcamentoTratamento) {
        this.especialidadeOrcamentoTratamento = especialidadeOrcamentoTratamento;
    }

    public String getEspecialidadeTratamento() {
        return especialidadeTratamento;
    }

    public void setEspecialidadeTratamento(String especialidadeTratamento) {
        this.especialidadeTratamento = especialidadeTratamento;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getEstadoCivil() {
        return estadoCivil;
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogradouro() {
        return logradouro;
    }

    public void setLogradouro(String logradouro) {
        this.logradouro = logradouro;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNomeDeUsuario() {
        return nomeDeUsuario;
    }

    public void setNomeDeUsuario(String nomeDeUsuario) {
        this.nomeDeUsuario = nomeDeUsuario;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Double getComissaoTratamento() {
        return comissaoTratamento;
    }

    public void setComissaoTratamento(Double comissaoTratamento) {
        this.comissaoTratamento = comissaoTratamento;
    }

    public Double getComissaoOrcamento() {
        return comissaoOrcamento;
    }

    public void setComissaoOrcamento(Double comissaoOrcamento) {
        this.comissaoOrcamento = comissaoOrcamento;
    }

    public Double getComissaoTratamentoOrcamento() {
        return comissaoTratamentoOrcamento;
    }

    public void setComissaoTratamentoOrcamento(Double comissaoTratamentoOrcamento) {
        this.comissaoTratamentoOrcamento = comissaoTratamentoOrcamento;
    }

    public Double getComissaoOrcamentoTratamento() {
        return comissaoOrcamentoTratamento;
    }

    public void setComissaoOrcamentoTratamento(Double comissaoOrcamentoTratamento) {
        this.comissaoOrcamentoTratamento = comissaoOrcamentoTratamento;
    }

    public String getRg() {
        return rg;
    }

    public void setRg(String rg) {
        this.rg = rg;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getFraseEsqueciMinhaSenha() {
        return fraseEsqueciMinhaSenha;
    }

    public void setFraseEsqueciMinhaSenha(String fraseEsqueciMinhaSenha) {
        this.fraseEsqueciMinhaSenha = fraseEsqueciMinhaSenha;
    }

    public char getSexo() {
        return sexo;
    }

    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public String getTelefoneCelular() {
        return telefoneCelular;
    }

    public void setTelefoneCelular(String telefoneCelular) {
        this.telefoneCelular = telefoneCelular;
    }

    public String getTelefoneFixo() {
        return telefoneFixo;
    }

    public void setTelefoneFixo(String telefoneFixo) {
        this.telefoneFixo = telefoneFixo;
    }

    public String[] getGrupoAcesso() {
        return grupoAcesso;
    }

    public void setGrupoAcesso(String[] grupoAcesso) {
        this.grupoAcesso = grupoAcesso;
    }
}