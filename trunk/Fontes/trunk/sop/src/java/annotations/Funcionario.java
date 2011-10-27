package annotations;

import java.util.Set;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

/**
 *
 * @author Fabricio P. Reis
 */
@Entity
@Table(name = "Funcionario")
@Inheritance(strategy = InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name = "id")
public class Funcionario extends Pessoa {
    //private static final long serialVersionUID = 1L;

    @Column(name = "nomeDeUsuario", nullable = false, unique = true)
    private String nomeDeUsuario;

    @Column(name = "senha", nullable = false)
    private String senha;

    @Column(name = "fraseEsqueciMinhaSenha", nullable = true)
    private String fraseEsqueciMinhaSenha;

    @Column(name = "cargo", nullable = false)
    private String cargo;

    @Column(name = "status", nullable = false)
    private char status;

    @Column(name = "codigoAutenticacao", nullable = false)
    private String codigoAutenticacao;

    @ManyToMany(fetch = FetchType.LAZY, targetEntity = GrupoAcesso.class)
    @JoinTable(name = "FuncionarioGrupoAcesso", joinColumns = {@JoinColumn(name = "funcionarioId", referencedColumnName = "id")}, inverseJoinColumns = {@JoinColumn(name = "grupoAcessoId", referencedColumnName = "id")})
    private Set<GrupoAcesso> grupoAcessoSet;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "funcionario", fetch = FetchType.LAZY, targetEntity = Pagamento.class)
    private Set<Pagamento> pagamentoSet;

    public Funcionario() {
    }

    public Funcionario(Integer id) {
        super(id);
    }

    public Funcionario(Integer id, String nome, char sexo, Date dataNascimento, String nomeDeUsuario, String senha, String fraseEsqueciMinhaSenha, String cargo, char status, String codigoAutenticacao) {
        super(id, nome, sexo, dataNascimento);
        this.nomeDeUsuario = nomeDeUsuario;
        this.senha = senha;
        this.fraseEsqueciMinhaSenha = fraseEsqueciMinhaSenha;
        this.cargo = cargo;
        this.status = status;
        this.codigoAutenticacao = codigoAutenticacao;
    }

    public String getNomeDeUsuario() {
        return nomeDeUsuario;
    }

    public void setNomeDeUsuario(String nomeDeUsuario) {
        this.nomeDeUsuario = nomeDeUsuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getFraseEsqueciMinhaSenha() {
        return fraseEsqueciMinhaSenha;
    }

    public void setFraseEsqueciMinhaSenha(String fraseEsqueciMinhaSenha) {
        this.fraseEsqueciMinhaSenha = fraseEsqueciMinhaSenha;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public String getCodigoAutenticacao() {
        return codigoAutenticacao;
    }

    public void setCodigoAutenticacao(String codigoAutenticacao) {
        this.codigoAutenticacao = codigoAutenticacao;
    }

    public Set<GrupoAcesso> getGrupoAcessoSet() {
        return grupoAcessoSet;
    }

    public void setGrupoAcessoSet(Set<GrupoAcesso> grupoAcessoSet) {
        this.grupoAcessoSet = grupoAcessoSet;
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
        hash += (super.getId() != null ? super.getId().hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Funcionario)) {
            return false;
        }
        Funcionario other = (Funcionario) object;
        if ((super.getId() == null && other.getId() != null) || (super.getId() != null && !super.getId().equals(other.getId()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "annotations.Funcionario[pessoaId=" + super.getId() + "]";
    }
}