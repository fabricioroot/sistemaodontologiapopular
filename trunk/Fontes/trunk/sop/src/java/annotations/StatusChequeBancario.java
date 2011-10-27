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
 * @author Fabricio P Reis
 */
@Entity
@Table(name = "StatusChequeBancario")
public class StatusChequeBancario implements Serializable {
    //private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Short id;

    @Column(name = "codigo", nullable = false, unique = true)
    private Short codigo;

    @Column(name = "nome", nullable = false, unique = true)
    private String nome;

    @Column(name = "descricao", nullable = false, unique = true)
    private String descricao;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "status", fetch = FetchType.LAZY, targetEntity = ChequeBancario.class)
    private Set<ChequeBancario> chequeBancarioSet;

    public StatusChequeBancario() {
    }

    public StatusChequeBancario(Short id) {
        this.id = id;
    }

    public StatusChequeBancario(Short id, String nome, String descricao) {
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

    public Short getCodigo() {
        return codigo;
    }

    public void setCodigo(Short codigo) {
        this.codigo = codigo;
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

    public Set<ChequeBancario> getChequeBancarioSet() {
        return chequeBancarioSet;
    }

    public void setChequeBancarioSet(Set<ChequeBancario> chequeBancarioSet) {
        this.chequeBancarioSet = chequeBancarioSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof StatusChequeBancario)) {
            return false;
        }
        StatusChequeBancario other = (StatusChequeBancario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.StatusChequeBancario[id=" + id + "]";
    }

}
