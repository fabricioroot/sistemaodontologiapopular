package web.chequeBancario;

/**
 * @author Fabricio P. Reis
 */
public class AtualizarChequeBancarioActionForm extends org.apache.struts.action.ActionForm {

    private Integer id;
    private Integer pagamentoId;
    private String nomePaciente;
    private Integer idPaciente;
    private String nomeTitular;
    private String cpfTitular;
    private String rgTitular;
    private String banco;
    private String outroBanco;
    private String numero;
    private Double valor;
    private String dataParaDepositar;
    private Short codigoStatusAtual;
    private Short codigoStatus;

    public AtualizarChequeBancarioActionForm() {
    }

    public String getBanco() {
        return banco;
    }

    public void setBanco(String banco) {
        this.banco = banco;
    }

    public Short getCodigoStatus() {
        return codigoStatus;
    }

    public void setCodigoStatus(Short codigoStatus) {
        this.codigoStatus = codigoStatus;
    }

    public Short getCodigoStatusAtual() {
        return codigoStatusAtual;
    }

    public void setCodigoStatusAtual(Short codigoStatusAtual) {
        this.codigoStatusAtual = codigoStatusAtual;
    }

    public String getCpfTitular() {
        return cpfTitular;
    }

    public void setCpfTitular(String cpfTitular) {
        this.cpfTitular = cpfTitular;
    }

    public String getDataParaDepositar() {
        return dataParaDepositar;
    }

    public void setDataParaDepositar(String dataParaDepositar) {
        this.dataParaDepositar = dataParaDepositar;
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

    public String getNomeTitular() {
        return nomeTitular;
    }

    public void setNomeTitular(String nomeTitular) {
        this.nomeTitular = nomeTitular;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getOutroBanco() {
        return outroBanco;
    }

    public void setOutroBanco(String outroBanco) {
        this.outroBanco = outroBanco;
    }

    public String getRgTitular() {
        return rgTitular;
    }

    public void setRgTitular(String rgTitular) {
        this.rgTitular = rgTitular;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }
}