package web.chequeBancario;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarChequeBancarioActionForm extends org.apache.struts.action.ActionForm {

    private Integer opcao;
    private String numero;
    private String dataInicio;
    private String dataFim;

    public ConsultarChequeBancarioActionForm() {
    }

    public String getDataFim() {
        return dataFim;
    }

    public void setDataFim(String dataFim) {
        this.dataFim = dataFim;
    }

    public String getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(String dataInicio) {
        this.dataInicio = dataInicio;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Integer getOpcao() {
        return opcao;
    }

    public void setOpcao(Integer opcao) {
        this.opcao = opcao;
    }
}