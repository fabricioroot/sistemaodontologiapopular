package web.procedimento;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarProcedimentoActionForm extends org.apache.struts.action.ActionForm {

    private String nome;

    public ConsultarProcedimentoActionForm() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
