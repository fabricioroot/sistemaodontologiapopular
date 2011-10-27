package web.comprovantePagamentoCartao;

/**
 *
 * @author Fabricio P. Reis
 */
public class CadastrarComprovantePagamentoCartaoActionForm extends org.apache.struts.action.ActionForm  {

    private String bandeira;
    private char tipo;
    private String codigoAutorizacao;
    private Double valor;
    private Short parcelas;

    public CadastrarComprovantePagamentoCartaoActionForm() {
    }

    public String getBandeira() {
        return bandeira;
    }

    public void setBandeira(String bandeira) {
        this.bandeira = bandeira;
    }

    public String getCodigoAutorizacao() {
        return codigoAutorizacao;
    }

    public void setCodigoAutorizacao(String codigoAutorizacao) {
        this.codigoAutorizacao = codigoAutorizacao;
    }

    public Short getParcelas() {
        return parcelas;
    }

    public void setParcelas(Short parcelas) {
        this.parcelas = parcelas;
    }

    public char getTipo() {
        return tipo;
    }

    public void setTipo(char tipo) {
        this.tipo = tipo;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }
}
