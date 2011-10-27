package annotations;

import java.io.Serializable;
import java.util.Set;
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

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Boca")
public class Boca implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Lob
    @Column(name = "observacao", nullable = true)
    private String observacao;

    @JoinColumn(name = "pacienteId", referencedColumnName = "id", nullable = false, unique = true)
    @OneToOne(optional = true, fetch = FetchType.LAZY, targetEntity = Paciente.class)
    private Paciente paciente;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "boca", fetch = FetchType.LAZY, targetEntity = Dente.class)
    private Set<Dente> denteSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "boca", fetch = FetchType.LAZY, targetEntity = HistoricoBoca.class)
    private Set<HistoricoBoca> historicoBocaSet;

    public Boca() {
    }

    public Boca(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Set<Dente> getDenteSet() {
        return denteSet;
    }

    public void setDenteSet(Set<Dente> denteSet) {
        this.denteSet = denteSet;
    }

    public Set<HistoricoBoca> getHistoricoBocaSet() {
        return historicoBocaSet;
    }

    public void setHistoricoBocaSet(Set<HistoricoBoca> historicoBocaSet) {
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
        if (!(object instanceof Boca)) {
            return false;
        }
        Boca other = (Boca) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Boca[id=" + id + "]";
    }

}
