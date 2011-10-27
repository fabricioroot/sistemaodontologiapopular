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
@Table(name = "HistoricoBoca")
public class HistoricoBoca implements Serializable {
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

    @JoinColumn(name = "statusProcedimentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = StatusProcedimento.class)
    private StatusProcedimento statusProcedimento;

    @JoinColumn(name = "bocaId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER, targetEntity = Boca.class)
    private Boca boca;

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

    public HistoricoBoca() {
    }

    public HistoricoBoca(Integer id) {
        this.id = id;
    }

    public HistoricoBoca(Integer id, Date dataHora) {
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

    public Boca getBoca() {
        return boca;
    }

    public void setBoca(Boca boca) {
        this.boca = boca;
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
        if (!(object instanceof HistoricoBoca)) {
            return false;
        }
        HistoricoBoca other = (HistoricoBoca) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.HistoricoBoca[id=" + id + "]";
    }

}
