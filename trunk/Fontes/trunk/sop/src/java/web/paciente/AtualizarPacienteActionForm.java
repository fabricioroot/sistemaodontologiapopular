package web.paciente;

/**
 *
 * @author Fabricio Reis
 */
public class AtualizarPacienteActionForm extends org.apache.struts.action.ActionForm {

    private Integer id;
    private String nome;
    private char sexo;
    private String estadoCivil;
    private String nomePai;
    private String nomeMae;
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
    private String indicacao;
    private String indicacaoOutra;
    private String impedimento;
    private char status;
    private Boolean filaOrcamento;
    private Boolean filaTratamento;

    public AtualizarPacienteActionForm() {
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
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

    public Integer getEnderecoId() {
        return enderecoId;
    }

    public void setEnderecoId(Integer enderecoId) {
        this.enderecoId = enderecoId;
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

    public Boolean isFilaOrcamento() {
        return filaOrcamento;
    }

    public void setFilaOrcamento(Boolean filaOrcamento) {
        this.filaOrcamento = filaOrcamento;
    }

    public Boolean isFilaTratamento() {
        return filaTratamento;
    }

    public void setFilaTratamento(Boolean filaTratamento) {
        this.filaTratamento = filaTratamento;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getImpedimento() {
        return impedimento;
    }

    public void setImpedimento(String impedimento) {
        this.impedimento = impedimento;
    }

    public String getIndicacao() {
        return indicacao;
    }

    public void setIndicacao(String indicacao) {
        this.indicacao = indicacao;
    }

    public String getIndicacaoOutra() {
        return indicacaoOutra;
    }

    public void setIndicacaoOutra(String indicacaoOutra) {
        this.indicacaoOutra = indicacaoOutra;
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

    public String getNomeMae() {
        return nomeMae;
    }

    public void setNomeMae(String nomeMae) {
        this.nomeMae = nomeMae;
    }

    public String getNomePai() {
        return nomePai;
    }

    public void setNomePai(String nomePai) {
        this.nomePai = nomePai;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getRg() {
        return rg;
    }

    public void setRg(String rg) {
        this.rg = rg;
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
}