package web.login;

/**
 *
 * @author Fabricio P. Reis
 */
public class LoginActionForm extends org.apache.struts.action.ActionForm {
    
    private String nomeDeUsuario;
    private String senha;

    public LoginActionForm() {
    }

    public LoginActionForm(String nomeDeUsuario, String senha) {
        this.nomeDeUsuario = nomeDeUsuario;
        this.senha = senha;
    }

    public String getNomeDeUsuario() {
        return nomeDeUsuario;
    }

    public void setNomeDeUsuario(String nomeDeUsuario) {
        this.nomeDeUsuario = nomeDeUsuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
