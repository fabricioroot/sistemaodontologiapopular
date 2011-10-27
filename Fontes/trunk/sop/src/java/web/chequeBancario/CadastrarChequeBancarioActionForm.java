package web.chequeBancario;

/**
 * @author Fabricio P. Reis
 */
public class CadastrarChequeBancarioActionForm extends org.apache.struts.action.ActionForm {

    private String nomeTitular;
    private String cpfTitular;
    private String rgTitular;
    private String banco;
    private String outroBanco;
    private String numero;
    private Double valor;
    private String dataParaDepositar;

    public CadastrarChequeBancarioActionForm() {
    }

    public String getBanco() {
        return banco;
    }

    public void setBanco(String banco) {
        this.banco = banco;
    }

    public String getOutroBanco() {
        return outroBanco;
    }

    public void setOutroBanco(String outroBanco) {
        this.outroBanco = outroBanco;
    }

    public String getCpfTitular() {
        return cpfTitular;
    }

    public void setCpfTitular(String cpfTitular) {
        this.cpfTitular = cpfTitular;
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

    public String getDataParaDepositar() {
        return dataParaDepositar;
    }

    public void setDataParaDepositar(String dataParaDepositar) {
        this.dataParaDepositar = dataParaDepositar;
    }
}