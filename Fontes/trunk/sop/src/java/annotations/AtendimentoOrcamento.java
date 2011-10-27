package annotations;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "AtendimentoOrcamento")
public class AtendimentoOrcamento implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "dataCriacao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCriacao;

    @Column(name = "dataInicio", nullable = true)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataInicio;

    @Column(name = "dataFim", nullable = true)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataFim;

    @Column(name = "prioridade", nullable = true)
    private Boolean prioridade;

    @Column(name = "comissaoDentista", nullable = false)
    private Double comissaoDentista;

    @JoinColumn(name = "fichaId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Ficha.class)
    private Ficha ficha;

    @JoinColumn(name = "dentistaId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Dentista.class)
    private Dentista dentista;

    @JoinColumn(name = "filaAtendimentoOrcamentoId", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY, targetEntity = FilaAtendimentoOrcamento.class)
    private FilaAtendimentoOrcamento filaAtendimentoOrcamento;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "atendimentoOrcamento", fetch = FetchType.LAZY, targetEntity = HistoricoDente.class)
    private Set<HistoricoDente> historicoDenteSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "atendimentoOrcamento", fetch = FetchType.LAZY, targetEntity = HistoricoBoca.class)
    private Set<HistoricoBoca> historicoBocaSet;

    public AtendimentoOrcamento() {
    }

    public AtendimentoOrcamento(Integer id) {
        this.id = id;
    }

    public AtendimentoOrcamento(Integer id, Date dataCriacao) {
        this.id = id;
        this.dataCriacao = dataCriacao;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(Date dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public Date getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(Date dataInicio) {
        this.dataInicio = dataInicio;
    }

    public Date getDataFim() {
        return dataFim;
    }

    public void setDataFim(Date dataFim) {
        this.dataFim = dataFim;
    }

    public Double getComissaoDentista() {
        return comissaoDentista;
    }

    public void setComissaoDentista(Double comissaoDentista) {
        this.comissaoDentista = comissaoDentista;
    }

    public Boolean isPrioridade() {
        return prioridade;
    }

    public void setPrioridade(Boolean prioridade) {
        this.prioridade = prioridade;
    }

    public Ficha getFicha() {
        return ficha;
    }

    public void setFicha(Ficha ficha) {
        this.ficha = ficha;
    }

    public Dentista getDentista() {
        return dentista;
    }

    public void setDentista(Dentista dentista) {
        this.dentista = dentista;
    }

    public FilaAtendimentoOrcamento getFilaAtendimentoOrcamento() {
        return filaAtendimentoOrcamento;
    }

    public void setFilaAtendimentoOrcamento(FilaAtendimentoOrcamento filaAtendimentoOrcamento) {
        this.filaAtendimentoOrcamento = filaAtendimentoOrcamento;
    }

    public Set<HistoricoDente> getHistoricoDenteSet() {
        return historicoDenteSet;
    }

    public void setHistoricoDenteSet(Set<HistoricoDente> historicoDenteSet) {
        this.historicoDenteSet = historicoDenteSet;
    }

    public Set<HistoricoBoca> gethistoricoBocaSet() {
        return historicoBocaSet;
    }

    public void sethistoricoBocaSet(Set<HistoricoBoca> historicoBocaSet) {
        this.historicoBocaSet = historicoBocaSet;
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
        if (!(object instanceof AtendimentoOrcamento)) {
            return false;
        }
        AtendimentoOrcamento other = (AtendimentoOrcamento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.AtendimentoOrcamento[id=" + id + "]";
    }
}