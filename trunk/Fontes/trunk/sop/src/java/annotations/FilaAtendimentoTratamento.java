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
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "FilaAtendimentoTratamento")
public class FilaAtendimentoTratamento implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "descricao", nullable = true)
    private String descricao;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "filaAtendimentoTratamento", fetch = FetchType.LAZY, targetEntity = AtendimentoTratamento.class)
    private Set<AtendimentoTratamento> atendimentoTratamentoSet;

    public FilaAtendimentoTratamento() {
    }

    public FilaAtendimentoTratamento(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Set<AtendimentoTratamento> getAtendimentoTratamentoSet() {
        return atendimentoTratamentoSet;
    }

    public void setAtendimentoTratamentoSet(Set<AtendimentoTratamento> atendimentoTratamentoSet) {
        this.atendimentoTratamentoSet = atendimentoTratamentoSet;
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
        if (!(object instanceof FilaAtendimentoTratamento)) {
            return false;
        }
        FilaAtendimentoTratamento other = (FilaAtendimentoTratamento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.FilaAtendimentoFicha[id=" + id + "]";
    }

}
