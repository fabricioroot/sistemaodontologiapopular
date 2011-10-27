package web.atendimentoOrcamento;

/**
 *
 * @author Fabricio P. Reis
 */
public class IncluirProcedimentoActionForm extends org.apache.struts.action.ActionForm {

    private Integer denteId;
    private String dentePosicao;
    private Short procedimentoId;
    private Double valorCobrado;
    private Double valorMinimo;
    private Double valorMinimoProcedimento;
    private String observacao;
    private String faceSuperior;
    private String faceEsquerda;
    private String faceMeio;
    private String faceDireita;
    private String faceInferior;
    private String raiz;
    private String tipoProcedimento;

    public IncluirProcedimentoActionForm() {
    }

    public Integer getDenteId() {
        return denteId;
    }

    public void setDenteId(Integer denteId) {
        this.denteId = denteId;
    }

    public String getDentePosicao() {
        return dentePosicao;
    }

    public void setDentePosicao(String dentePosicao) {
        this.dentePosicao = dentePosicao;
    }

    public String getFaceDireita() {
        return faceDireita;
    }

    public void setFaceDireita(String faceDireita) {
        this.faceDireita = faceDireita;
    }

    public String getFaceEsquerda() {
        return faceEsquerda;
    }

    public void setFaceEsquerda(String faceEsquerda) {
        this.faceEsquerda = faceEsquerda;
    }

    public String getFaceInferior() {
        return faceInferior;
    }

    public void setFaceInferior(String faceInferior) {
        this.faceInferior = faceInferior;
    }

    public String getFaceMeio() {
        return faceMeio;
    }

    public void setFaceMeio(String faceMeio) {
        this.faceMeio = faceMeio;
    }

    public String getFaceSuperior() {
        return faceSuperior;
    }

    public void setFaceSuperior(String faceSuperior) {
        this.faceSuperior = faceSuperior;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public String getRaiz() {
        return raiz;
    }

    public void setRaiz(String raiz) {
        this.raiz = raiz;
    }

    public String getTipoProcedimento() {
        return tipoProcedimento;
    }

    public void setTipoProcedimento(String tipoProcedimento) {
        this.tipoProcedimento = tipoProcedimento;
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

    public Double getValorMinimoProcedimento() {
        return valorMinimoProcedimento;
    }

    public void setValorMinimoProcedimento(Double valorMinimoProcedimento) {
        this.valorMinimoProcedimento = valorMinimoProcedimento;
    }
}