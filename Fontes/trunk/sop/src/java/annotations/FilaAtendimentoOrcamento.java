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
@Table(name = "FilaAtendimentoOrcamento")
public class FilaAtendimentoOrcamento implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "descricao", nullable = true)
    private String descricao;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "filaAtendimentoOrcamento", fetch = FetchType.LAZY, targetEntity = AtendimentoOrcamento.class)
    private Set<AtendimentoOrcamento> atendimentoOrcamentoSet;

    public FilaAtendimentoOrcamento() {
    }

    public FilaAtendimentoOrcamento(Integer id) {
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

    public Set<AtendimentoOrcamento> getAtendimentoOrcamentoSet() {
        return atendimentoOrcamentoSet;
    }

    public void setAtendimentoOrcamentoSet(Set<AtendimentoOrcamento> atendimentoOrcamentoSet) {
        this.atendimentoOrcamentoSet = atendimentoOrcamentoSet;
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
        if (!(object instanceof FilaAtendimentoOrcamento)) {
            return false;
        }
        FilaAtendimentoOrcamento other = (FilaAtendimentoOrcamento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.FilaAtendimentoFichaOrcamento[id=" + id + "]";
    }

}
