package web.funcionario;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarFuncionarioActionForm extends org.apache.struts.action.ActionForm {

    private String nome;

    public ConsultarFuncionarioActionForm() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
