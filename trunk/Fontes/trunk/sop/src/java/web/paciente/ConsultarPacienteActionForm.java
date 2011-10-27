package web.paciente;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarPacienteActionForm extends org.apache.struts.action.ActionForm {

    private Integer opcao;
    private String nome;
    private String cpf;
    private String codigo;
    private String logradouro;

    public ConsultarPacienteActionForm() {
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
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

    public Integer getOpcao() {
        return opcao;
    }

    public void setOpcao(Integer opcao) {
        this.opcao = opcao;
    }
}
