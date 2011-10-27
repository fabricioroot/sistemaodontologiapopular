package annotations;

import java.io.Serializable;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "GrupoAcesso")
public class GrupoAcesso implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Short id;

    @Column(name = "nome", nullable = false, unique = true)
    private String nome;

    @Column(name = "descricao", nullable = false, unique = true)
    private String descricao;

    @ManyToMany(mappedBy = "grupoAcessoSet", targetEntity = Funcionario.class)
    private Set<Funcionario> funcionarioSet;

    public GrupoAcesso() {
    }

    public GrupoAcesso(Short id) {
        this.id = id;
    }

    public GrupoAcesso(Short id, String nome, String descricao) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
    }

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Set<Funcionario> getFuncionarioSet() {
        return funcionarioSet;
    }

    public void setFuncionarioSet(Set<Funcionario> funcionarioSet) {
        this.funcionarioSet = funcionarioSet;
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
        if (!(object instanceof GrupoAcesso)) {
            return false;
        }
        GrupoAcesso other = (GrupoAcesso) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.GrupoAcesso[id=" + id + "]";
    }

}
