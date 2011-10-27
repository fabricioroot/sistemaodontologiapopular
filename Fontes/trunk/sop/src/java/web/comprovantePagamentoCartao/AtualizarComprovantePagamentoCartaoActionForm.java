package web.comprovantePagamentoCartao;

/**
 *
 * @author Fabricio P. Reis
 */
public class AtualizarComprovantePagamentoCartaoActionForm  extends org.apache.struts.action.ActionForm {

    private Integer id;
    private Integer pagamentoId;
    private String nomePaciente;
    private Integer idPaciente;
    private String bandeira;
    private char tipo;
    private String codigoAutorizacao;
    private Double valor;
    private Short parcelas;
    private char status;
    private char statusAtual;
    private String dataPagamento;

    public AtualizarComprovantePagamentoCartaoActionForm() {
    }

     public String getNomePaciente() {
        return nomePaciente;
    }

    public void setNomePaciente(String nomePaciente) {
        this.nomePaciente = nomePaciente;
    }

    public Integer getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(Integer idPaciente) {
        this.idPaciente = idPaciente;
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

    public String getDataPagamento() {
        return dataPagamento;
    }

    public void setDataPagamento(String dataPagamento) {
        this.dataPagamento = dataPagamento;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPagamentoId() {
        return pagamentoId;
    }

    public void setPagamentoId(Integer pagamentoId) {
        this.pagamentoId = pagamentoId;
    }

    public Short getParcelas() {
        return parcelas;
    }

    public void setParcelas(Short parcelas) {
        this.parcelas = parcelas;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public char getStatusAtual() {
        return statusAtual;
    }

    public void setStatusAtual(char statusAtual) {
        this.statusAtual = statusAtual;
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
