package web.formaPagamento;

/**
 *
 * @author Fabricio Reis
 */
public class CadastrarFormaPagamentoActionForm extends org.apache.struts.action.ActionForm {

    private String nome;
    private String descricao;
    private char status;
    private char tipo;
    private Double valorMinimoAPrazo;
    private Double desconto;
    private Double pisoParaDesconto;

    public CadastrarFormaPagamentoActionForm() {
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public char getTipo() {
        return tipo;
    }

    public void setTipo(char tipo) {
        this.tipo = tipo;
    }

    public Double getValorMinimoAPrazo() {
        return valorMinimoAPrazo;
    }

    public void setValorMinimoAPrazo(Double valorMinimoAPrazo) {
        this.valorMinimoAPrazo = valorMinimoAPrazo;
    }

    public Double getDesconto() {
        return desconto;
    }

    public void setDesconto(Double desconto) {
        this.desconto = desconto;
    }

    public Double getPisoParaDesconto() {
        return pisoParaDesconto;
    }

    public void setPisoParaDesconto(Double pisoParaDesconto) {
        this.pisoParaDesconto = pisoParaDesconto;
    }
}