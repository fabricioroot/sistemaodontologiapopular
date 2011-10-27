package annotations;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "HistoricoDente")
public class HistoricoDente implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "valorCobrado", nullable = false)
    private Double valorCobrado;

    @Column(name = "dataHora", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataHora;

    @Lob
    @Column(name = "observacao", nullable = true)
    private String observacao;

    @Column(name = "faceDistal", nullable = true)
    private Boolean faceDistal; // parte de tras

    @Column(name = "faceMesial", nullable = true)
    private Boolean faceMesial; // parte da frente

    @Column(name = "faceIncisal", nullable = true)
    private Boolean faceIncisal; // parte de cima

    @Column(name = "faceBucal", nullable = true)
    private Boolean faceBucal; // voltada para os labios e bochecha

    @Column(name = "faceLingual", nullable = true)
    private Boolean faceLingual; // voltada para a lingua ou ceu da boca

    @Column(name = "raiz", nullable = true)
    private Boolean raiz;

    @JoinColumn(name = "statusProcedimentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = StatusProcedimento.class)
    private StatusProcedimento statusProcedimento;

    @JoinColumn(name = "denteId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = Dente.class)
    private Dente dente;

    @JoinColumn(name = "dentistaId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Dentista.class)
    private Dentista dentista;

    @JoinColumn(name = "procedimentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = Procedimento.class)
    private Procedimento procedimento;

    @JoinColumn(name = "atendimentoOrcamentoId", referencedColumnName = "id", nullable = true)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = AtendimentoOrcamento.class)
    private AtendimentoOrcamento atendimentoOrcamento;

    @JoinColumn(name = "atendimentoTratamentoId", referencedColumnName = "id", nullable = true)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = AtendimentoTratamento.class)
    private AtendimentoTratamento atendimentoTratamento;

    public HistoricoDente() {
    }

    public HistoricoDente(Integer id) {
        this.id = id;
    }

    public HistoricoDente(Integer id, Date dataHora) {
        this.id = id;
        this.dataHora = dataHora;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getValorCobrado() {
        return valorCobrado;
    }

    public void setValorCobrado(Double valorCobrado) {
        this.valorCobrado = valorCobrado;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Boolean getFaceDistal() {
        return faceDistal;
    }

    public void setFaceDistal(Boolean faceDistal) {
        this.faceDistal = faceDistal;
    }

    public Boolean getFaceMesial() {
        return faceMesial;
    }

    public void setFaceMesial(Boolean faceMesial) {
        this.faceMesial = faceMesial;
    }

    public Boolean getFaceIncisal() {
        return faceIncisal;
    }

    public void setFaceIncisal(Boolean faceIncisal) {
        this.faceIncisal = faceIncisal;
    }

    public Boolean getFaceBucal() {
        return faceBucal;
    }

    public void setFaceBucal(Boolean faceBucal) {
        this.faceBucal = faceBucal;
    }

    public Boolean getFaceLingual() {
        return faceLingual;
    }

    public void setFaceLingual(Boolean faceLingual) {
        this.faceLingual = faceLingual;
    }

    public Boolean getRaiz() {
        return raiz;
    }

    public void setRaiz(Boolean raiz) {
        this.raiz = raiz;
    }

    public Dente getDente() {
        return dente;
    }

    public void setDente(Dente dente) {
        this.dente = dente;
    }

    public Dentista getDentista() {
        return dentista;
    }

    public void setDentista(Dentista dentista) {
        this.dentista = dentista;
    }

    public Procedimento getProcedimento() {
        return procedimento;
    }

    public void setProcedimento(Procedimento procedimento) {
        this.procedimento = procedimento;
    }

    public StatusProcedimento getStatusProcedimento() {
        return statusProcedimento;
    }

    public void setStatusProcedimento(StatusProcedimento statusProcedimento) {
        this.statusProcedimento = statusProcedimento;
    }

    public AtendimentoOrcamento getAtendimentoOrcamento() {
        return atendimentoOrcamento;
    }

    public void setAtendimentoOrcamento(AtendimentoOrcamento atendimentoOrcamento) {
        this.atendimentoOrcamento = atendimentoOrcamento;
    }

    public AtendimentoTratamento getAtendimentoTratamento() {
        return atendimentoTratamento;
    }

    public void setAtendimentoTratamento(AtendimentoTratamento atendimentoTratamento) {
        this.atendimentoTratamento = atendimentoTratamento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof HistoricoDente)) {
            return false;
        }
        HistoricoDente other = (HistoricoDente) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.HistoricoDente[id=" + id + "]";
    }

}
