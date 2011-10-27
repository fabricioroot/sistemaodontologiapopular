package web.caixa;

/**
 * @author Fabricio P. Reis
 */
public class FaturarPagamentoActionForm extends org.apache.struts.action.ActionForm {

    private Short formaPagamentoId;
    // Pagamento a vista
    private Double subtotalAVista;
    //private Double totalAVistaComDesconto;   // Trecho de codigo para quando for usar desconto no pagamento a vista
    private Double totalAVista;
    private Double totalAVistaEmDinheiro;
    // Pagamento a prazo
    private Double subtotalAPrazo;
    private Double totalAPrazo;
    private Double totalAPrazoEmDinheiro;
    // Geral
    private Double totalCheques;
    private Double totalCartao;

    public FaturarPagamentoActionForm() {
    }

    public Short getFormaPagamentoId() {
        return formaPagamentoId;
    }

    public void setFormaPagamentoId(Short formaPagamentoId) {
        this.formaPagamentoId = formaPagamentoId;
    }

    public Double getSubtotalAPrazo() {
        return subtotalAPrazo;
    }

    public void setSubtotalAPrazo(Double subtotalAPrazo) {
        this.subtotalAPrazo = subtotalAPrazo;
    }

    public Double getSubtotalAVista() {
        return subtotalAVista;
    }

    public void setSubtotalAVista(Double subtotalAVista) {
        this.subtotalAVista = subtotalAVista;
    }

    public Double getTotalAPrazo() {
        return totalAPrazo;
    }

    public void setTotalAPrazo(Double totalAPrazo) {
        this.totalAPrazo = totalAPrazo;
    }

    public Double getTotalAPrazoEmDinheiro() {
        return totalAPrazoEmDinheiro;
    }

    public void setTotalAPrazoEmDinheiro(Double totalAPrazoEmDinheiro) {
        this.totalAPrazoEmDinheiro = totalAPrazoEmDinheiro;
    }

    public Double getTotalAVista() {
        return totalAVista;
    }

    public void setTotalAVista(Double totalAVista) {
        this.totalAVista = totalAVista;
    }

    // Trecho de codigo para quando for usar desconto no pagamento a vista
    /*public Double getTotalAVistaComDesconto() {
        return totalAVistaComDesconto;
    }

    public void setTotalAVistaComDesconto(Double totalAVistaComDesconto) {
        this.totalAVistaComDesconto = totalAVistaComDesconto;
    }*/

    public Double getTotalAVistaEmDinheiro() {
        return totalAVistaEmDinheiro;
    }

    public void setTotalAVistaEmDinheiro(Double totalAVistaEmDinheiro) {
        this.totalAVistaEmDinheiro = totalAVistaEmDinheiro;
    }

    public Double getTotalCartao() {
        return totalCartao;
    }

    public void setTotalCartao(Double totalCartao) {
        this.totalCartao = totalCartao;
    }

    public Double getTotalCheques() {
        return totalCheques;
    }

    public void setTotalCheques(Double totalCheques) {
        this.totalCheques = totalCheques;
    }
}