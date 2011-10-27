package web.comprovantePagamentoCartao;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarComprovantePagamentoCartaoActionForm extends org.apache.struts.action.ActionForm {

    private Integer opcao;
    private String codigoAutorizacao;
    private String dataInicio;
    private String dataFim;

    public ConsultarComprovantePagamentoCartaoActionForm() {
    }

    public String getCodigoAutorizacao() {
        return codigoAutorizacao;
    }

    public void setCodigoAutorizacao(String codigoAutorizacao) {
        this.codigoAutorizacao = codigoAutorizacao;
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

    public Integer getOpcao() {
        return opcao;
    }

    public void setOpcao(Integer opcao) {
        this.opcao = opcao;
    }
}
