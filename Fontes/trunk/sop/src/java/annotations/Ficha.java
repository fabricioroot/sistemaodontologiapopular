package annotations;

import java.io.Serializable;
import java.util.Set;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Ficha")
public class Ficha implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "dataCriacao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCriacao;

    @Column(name = "dataUltimaConsulta", nullable = true)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUltimaConsulta;

    @Lob
    @Column(name = "observacao", nullable = true)
    private String observacao;

    @Column(name = "saldo", nullable = false)
    private Double saldo;

    @JoinColumn(name = "pacienteId", referencedColumnName = "id", nullable = false, unique = true)
    @OneToOne(optional = false, fetch = FetchType.LAZY, targetEntity = Paciente.class)
    private Paciente paciente;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ficha", fetch = FetchType.LAZY, targetEntity = AtendimentoTratamento.class)
    private Set<AtendimentoTratamento> atendimentoTratamentoSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ficha", fetch = FetchType.LAZY, targetEntity = AtendimentoOrcamento.class)
    private Set<AtendimentoOrcamento> atendimentoOrcamentoSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ficha", fetch = FetchType.LAZY, targetEntity = Pagamento.class)
    private Set<Pagamento> pagamentoSet;

    public Ficha() {
    }

    public Ficha(Integer id) {
        this.id = id;
    }

    public Ficha(Integer id, Date dataCriacao, Date dataUltimaConsulta, Double saldo) {
        this.id = id;
        this.dataCriacao = dataCriacao;
        this.dataUltimaConsulta = dataUltimaConsulta;
        this.saldo = saldo;
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

    public Date getDataUltimaConsulta() {
        return dataUltimaConsulta;
    }

    public void setDataUltimaConsulta(Date dataUltimaConsulta) {
        this.dataUltimaConsulta = dataUltimaConsulta;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Double getSaldo() {
        return saldo;
    }

    public void setSaldo(Double saldo) {
        this.saldo = saldo;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Set<AtendimentoTratamento> getAtendimentoTratamentoSet() {
        return atendimentoTratamentoSet;
    }

    public void setAtendimentoTratamentoSet(Set<AtendimentoTratamento> atendimentoTratamentoSet) {
        this.atendimentoTratamentoSet = atendimentoTratamentoSet;
    }

    public Set<AtendimentoOrcamento> getAtendimentoOrcamentoSet() {
        return atendimentoOrcamentoSet;
    }

    public void setAtendimentoOrcamentoSet(Set<AtendimentoOrcamento> atendimentoOrcamentoSet) {
        this.atendimentoOrcamentoSet = atendimentoOrcamentoSet;
    }

    public Set<Pagamento> getPagamentoSet() {
        return pagamentoSet;
    }

    public void setPagamentoSet(Set<Pagamento> pagamentoSet) {
        this.pagamentoSet = pagamentoSet;
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
        if (!(object instanceof Ficha)) {
            return false;
        }
        Ficha other = (Ficha) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Ficha[id=" + id + "]";
    }

}
