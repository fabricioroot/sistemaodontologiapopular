package web.formaPagamento;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarFormaPagamentoActionForm extends org.apache.struts.action.ActionForm {

    private String nome;
    private char tipo;
    private Integer opcao;

    public ConsultarFormaPagamentoActionForm() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public char getTipo() {
        return tipo;
    }

    public void setTipo(char tipo) {
        this.tipo = tipo;
    }

    public Integer getOpcao() {
        return opcao;
    }

    public void setOpcao(Integer opcao) {
        this.opcao = opcao;
    }
}
