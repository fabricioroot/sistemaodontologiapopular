package web.atendimentoOrcamento;

/**
 *
 * @author Fabricio P. Reis
 */
public class IncluirProcedimentoBocaActionForm extends org.apache.struts.action.ActionForm {

    private Integer bocaId;
    private Short procedimentoId;
    private Double valorCobrado;
    private Double valorMinimo;
    private String observacao;

    public IncluirProcedimentoBocaActionForm() {
    }

    public Integer getBocaId() {
        return bocaId;
    }

    public void setBocaId(Integer bocaId) {
        this.bocaId = bocaId;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Short getProcedimentoId() {
        return procedimentoId;
    }

    public void setProcedimentoId(Short procedimentoId) {
        this.procedimentoId = procedimentoId;
    }

    public Double getValorCobrado() {
        return valorCobrado;
    }

    public void setValorCobrado(Double valorCobrado) {
        this.valorCobrado = valorCobrado;
    }

    public Double getValorMinimo() {
        return valorMinimo;
    }

    public void setValorMinimo(Double valorMinimo) {
        this.valorMinimo = valorMinimo;
    }
}